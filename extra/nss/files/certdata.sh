#!/bin/sh -eu

# Run `sed -e 's|}$|},|' -e 's|,.*[A-Z]$|&,|' -e 's|,  |, |g'` on the perl
# output for an accurate diff

exec > "$2"

cat << EOF
/* THIS IS A GENERATED FILE */
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

#ifndef BUILTINS_H
#include "builtins.h"
#endif /* BUILTINS_H */

EOF

tolower()
{
    tr '[:upper:]' '[:lower:]' << EOF
$1
EOF
}

count()
{
    tr -dc "$2" << EOF | wc -m
$1
EOF
}

while read -r attr typ val; do
    case $attr in
        ''|\#*|BEGINDATA) continue
    esac

    case $typ in
        CK_*) printf 'static const %s %s = %s;\n' "$typ" "$(tolower "$val")" "$val";
    esac
done < "$1" | sort -u

cnt=0
while read -r attr typ val; do
    case $attr in
        ''|\#*|BEGINDATA) continue ;;
        CKA_CLASS)
            [ "$cnt" -eq 0 ] || printf '\n};\n'
            printf 'static const CK_ATTRIBUTE_TYPE nss_builtins_types_%d [] = {\n' \
                "$((cnt += 1))"
        ;;
    esac

    case $attr in CKA_*)
        printf ' %s,' "$attr"
    esac
done < "$1"
printf '\n};\n'

cnt=0
is_multiline_octal=0
datasz=0
while read -r attr typ val; do
    case $attr in
        ''|\#*|BEGINDATA) continue ;;
        CKA_CLASS)
            [ "$cnt" -eq 0 ] || printf '};\n'
            printf 'static const NSSItem nss_builtins_items_%d [] = {\n' \
                "$((cnt += 1))"
        ;;
    esac

    if [ "$is_multiline_octal" = 1 ]; then
        case $attr in
            END)
                printf ', (PRUint32)%d },\n' "$datasz"
                is_multiline_octal=0
                datasz=0
            ;;
            *)
                printf '"%s"\n' "$attr"
                : $((datasz += $(count "$attr" '\')))
            ;;
        esac
        continue
    fi

    case $typ in
        UTF8)
            strsz="$(printf '%s' "$val" | wc -c)"
            : $((strsz -= 2)) # ""
            : $((strsz += 1)) # \0
            printf '  { (void *)%s, (PRUint32)%d },\n' \
                "$val" "$strsz"
        ;;
        MULTILINE_OCTAL)
            is_multiline_octal=1
            datasz=0
            printf '  { (void *)'
        ;;
        *)
            printf '  { (void *)&%s, (PRUint32)sizeof(%s) },\n' \
                "$(tolower "$val")" "$typ"
        ;;
    esac
done < "$1"
printf '};\n'

printf "\nbuiltinsInternalObject\nnss_builtins_data[] = {\n";

cnt=0
objsize=0
while read -r attr typ val; do
    case $attr in
        ''|\#*|BEGINDATA) continue ;;
        CKA_CLASS)
            [ "$cnt" = 0 ] || printf "  { %d, nss_builtins_types_%d, nss_builtins_items_%d, {NULL} },\n" \
                "$objsize" "$cnt" "$cnt"
            objsize=0
            : $((cnt += 1))
        ;;
    esac

    case $attr in CKA_*)
        : $((objsize += 1))
    esac
done < "$1"
printf "  { %d, nss_builtins_types_%d, nss_builtins_items_%d, {NULL} },\n" \
    "$objsize" "$cnt" "$cnt"
printf '};\n'

printf 'const PRUint32\nnss_builtins_nObjects = %d;\n' "$cnt"
