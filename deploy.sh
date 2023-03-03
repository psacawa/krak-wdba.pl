#!/usr/bin/env zsh

S3_BUCKET=886185890074-krakowdba.pl
CLOUDFRONT_DIST_ID=EOL5C36SU2ZPK
OUTPUT_DIR=public

# zmienione pliki od ostatniej rewizji - można by ulepszyć
# zepsute
# CHANGED_cILES=($(git diff --name-only @^))

hugo
aws s3 sync $OUTPUT_DIR "s3://$S3_BUCKET" --acl public-read --delete
aws cloudfront create-invalidation \
    --distribution-id $CLOUDFRONT_DIST_ID  \
    --no-cli-pager \
    --paths /
