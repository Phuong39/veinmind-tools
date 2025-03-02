# compliant: No duplicate aliases defined in different FROMs
FROM veinmind/base:1.5.3-slim as compressor
USER notroot
WORKDIR /tool
COPY --from=release --link /build/veinmind-iac .
RUN echo "#!/bin/bash\n\n./veinmind-iac \$*" > /tool/entrypoint.sh && chmod +x /tool/entrypoint.sh && chmod +x /tool/veinmind-iac
HEALTHCHECK CMD curl -f http://localhost/ || exit 1

FROM veinmind/base:1.5.4-slim as compressor1
USER notroot
COPY --link /build/veinmind-iac .
RUN echo "#!/bin/bash\n\n./veinmind-iac \$*" > /tool/entrypoint.sh && chmod +x /tool/entrypoint.sh && chmod +x /tool/veinmind-iac
ENTRYPOINT ["/tool/entrypoint.sh"]