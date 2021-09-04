# Rsync Information

Sync directory including all directory and .cer files but excuding every else:

`rsync -a --prune-empty-dirs --include '*/' --include '*.cer' --exclude '*' /certs/ /out_certs`
