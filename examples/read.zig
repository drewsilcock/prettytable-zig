const std = @import("std");

const FORMAT_BOX_CHARS = @import("prettytable").FORMAT_BOX_CHARS;
const Table = @import("prettytable").Table;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}).init;
    defer std.debug.assert(gpa.deinit() == .ok);
    const allocator = gpa.allocator();

    const data =
        \\name, id, favorite food
        \\beau, 2, cereal
        \\abbey, 3, pizza
        \\
    ;

    var s = std.io.fixedBufferStream(data);
    const reader = s.reader();
    var table = Table.init(allocator);
    defer table.deinit();

    var read_buf: [1024]u8 = undefined;
    try table.readFrom(reader, &read_buf, ",", true);

    try table.printstd();
    // +-------+-----+----------------+
    // | name  |  id |  favorite food |
    // +=======+=====+================+
    // | beau  |  2  |  cereal        |
    // +-------+-----+----------------+
    // | abbey |  3  |  pizza         |
    // +-------+-----+----------------+

}
