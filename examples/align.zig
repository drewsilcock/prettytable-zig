const std = @import("std");

const Alignment = @import("prettytable").Alignment;
const FORMAT_BOX_CHARS = @import("prettytable").FORMAT_BOX_CHARS;
const Table = @import("prettytable").Table;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}).init;
    defer std.debug.assert(gpa.deinit() == .ok);
    const allocator = gpa.allocator();

    var table = Table.init(allocator);
    defer table.deinit();

    try table.addRows(&[_][]const []const u8{
        &[_][]const u8{ "foo", "foooooo", "bar" },
        &[_][]const u8{ "1", "2", "3" },
    });

    table.setAlign(Alignment.right);

    try table.printstd();
    // +-----+---------+-----+
    // | foo | foooooo | bar |
    // +-----+---------+-----+
    // |   1 |       2 |   3 |
    // +-----+---------+-----+

}
