#!/bin/bash

sed -i.bak "s/'checkout'/'checkout', '--trust-server-cert'/" ./manage_externals/manic/repository_svn.py
./manage_externals/checkout_externals


cp .config_files.xml  ${PREFIX}/

cat > config_files_xml.patch <<EOF
--- /data/ctsm-release-emerald-platform3.0.0/.config_files.xml	2021-01-30 14:46:01.084607799 +0000
+++ .config_files.xml	2021-01-30 14:38:58.249829449 +0000
@@ -29,4 +29,13 @@
     <schema>\$CIMEROOT/config/xml_schemas/config_compsets.xsd</schema>
   </entry>
 
+  <entry id="MACHINES_SPEC_FILE">
+     <type>char</type>
+     <default_value>\$CIMEROOT/config/cesm/machines/config_machines.xml</default_value>
+     <group>case_last</group>
+     <file>env_case.xml</file>
+     <desc>file containing machine specifications for target model primary component (for documentation only - DO NOT EDIT)</desc>
+     <schema>\$CIMEROOT/config/xml_schemas/config_machines.xsd</schema>
+   </entry>
+
 </entry_id>
EOF

patch ${PREFIX}/.config_files.xml config_files_xml.patch

mkdir -p ${PREFIX}/bin
cp -r cime ${PREFIX}/
cp -r cime_config ${PREFIX}/
cp -r components ${PREFIX}/
cp -r src ${PREFIX}/
cp -r bld ${PREFIX}/

cd ${PREFIX}/bin/
ln -s ../cime/scripts/create_* .
ln -s ../cime/scripts/query_* .
