#!/usr/bin/env bash
rm -f bin/temp.json
java -jar ./bin/MushroomCloud.jar --data ./test/data ./test/sql/tpch_schemas.sql ./test/sql/tpch3.sql > bin/temp.json
./bin/llvmruntime < bin/temp.json