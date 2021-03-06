import Table, {Record} from "./Table"
import Column from "../column/Column"
import ColumnTypes from "../../../define/db/ColumnTypes"

export default class RegionalEntryTable extends Table {
    public static tableName: string = "regional_entry"
    public static columns: Column[] = [
        new Column("id", ColumnTypes.serial, false, null, true),
        new Column("name", ColumnTypes.text, true),
        new Column("tag_ids", ColumnTypes.intArray, false),
        // BASE64 画像データ
        // TODO: bytea型へ変換する
        new Column("images", ColumnTypes.textArray, false),
        new Column("text", ColumnTypes.text, true),
        new Column("regional_id", ColumnTypes.int, true),
        new Column("sub_regional_id", ColumnTypes.int, false),
        new Column("latlng", ColumnTypes.point, false)
    ]
}

export class RegionalEntryRecord extends Record {}

RegionalEntryTable.RecordClass = RegionalEntryRecord
RegionalEntryRecord.TableClass = RegionalEntryTable
