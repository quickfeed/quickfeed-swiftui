//
//  StudentLabOverview.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 28/01/2021.
//

import SwiftUI

struct StudentLabOverview: View {
    var lab: AssignmentModel
    var side: Int
    var scoreLimit: Int
    var scoreValue: Float = 70
    var status: String = "None" //Approved, Rejected, None, Revision.
    var feedback: String = """
                            *** Preparing for Test Execution ***
                            *** Finished Test Setup in 5 seconds ***
                            *** Running Tests ***
                            go: downloading github.com/golang/protobuf v1.4.3
                            go: downloading google.golang.org/grpc v1.33.1
                            go: downloading github.com/blang/vfs v1.0.0
                            go: downloading google.golang.org/protobuf v1.25.0
                            go: downloading github.com/google/go-cmp v0.5.2
                            go: downloading github.com/autograde/quickfeed/kit v0.0.0-20201027142001-91e9d79a2748
                            go: downloading google.golang.org/genproto v0.0.0-20200526211855-cb27e3aa2013
                            go: downloading golang.org/x/net v0.0.0-20201027133719-8eef5233e2a1
                            go: downloading golang.org/x/sys v0.0.0-20201028094953-708e7fb298ac
                            go: downloading golang.org/x/text v0.3.4
                            === RUN TestLintAG
                            TestLintAG: 2/2 test cases passed
                            --- PASS: TestLintAG (1.23s)
                            PASS
                            ok dat320/lab8 1.240s
                            testing: warning: no tests to run
                            PASS
                            ok dat320/lab8/grpcfs 0.009s [no tests to run]
                            ? dat320/lab8/grpcfs/cmd/fs [no test files]
                            === RUN TestDataRaceAG
                            command_line.go:74: TestDataRaceAG
                            exit status 1: .
                            TestDataRaceAG: 1/1 test cases passed
                            data_race_ag_test.go:121: Full output:
                            --- FAIL: TestConcurrentFileOperationsAG (2.72s)
                            data_race_ag_test.go:192: Close(): file does not exist
                            (open a file, write something, seek to start, read what was written, close the file)
                            data_race_ag_test.go:192: Write([115 111 109 101 32]): file does not exist
                            (open a file, write 5 strings, seek to somewhere in the file, read part of what was written, close the file)
                            data_race_ag_test.go:192: Open("c", OpenReadWrite) = rpc error: code = AlreadyExists desc = file already exists, want <nil>
                            (open a file, write 5 strings, seek to somewhere in the file, read part of what was written, close the file)
                            data_race_ag_test.go:192: Open("a", OpenReadWrite) = rpc error: code = AlreadyExists desc = file already exists, want <nil>
                            (open a file write-only, close it, open the file read-write, close it, open the file read-only -> fail, try to close the file which failed to open -> fail)
                            data_race_ag_test.go:192: Close(): file does not exist
                            (open a file, write 5 strings, seek to somewhere in the file, read part of what was written, close the file)
                            data_race_ag_test.go:192: Open("b", OpenReadWrite) = rpc error: code = AlreadyExists desc = file already exists, want <nil>
                            (open a file, write 5 strings, seek to somewhere in the file, read part of what was written, close the file)
                            data_race_ag_test.go:192: Open("a", OpenReadWrite) = rpc error: code = AlreadyExists desc = file already exists, want <nil>
                            (open a file, write something, seek to start, read what was written, close the file)
                            data_race_ag_test.go:192: Open("b", OpenReadWrite) = rpc error: code = AlreadyExists desc = file already exists, want <nil>
                            (open a file, write something, seek to start, read what was written, close the file)
                            data_race_ag_test.go:192: Write([115 111 109 101 32 115 116 114 105 110 103]): file does not exist
                            (open a file, write something, seek to start, read what was written, close the file)
                            data_race_ag_test.go:192: Close(): file does not exist
                            (open a file write-only, close it, open the file read-write, close it, open the file read-only -> fail, try to close the file which failed to open -> fail)
                            data_race_ag_test.go:192: Write([115 116 114 105 110 103 32]): file does not exist
                            (open a file, write 5 strings, seek to somewhere in the file, read part of what was written, close the file)
                            data_race_ag_test.go:192: Write([119 114 105 116 116 101 110]): file does not exist
                            (open a file, write 5 strings, seek to somewhere in the file, read part of what was written, close the file)
                            data_race_ag_test.go:192: Open("a", OpenReadWrite) = rpc error: code = AlreadyExists desc = file already exists, want <nil>
                            (open a file, write 5 strings, seek to somewhere in the file, read part of what was written, close the file)
                            data_race_ag_test.go:192: Read([0 0 0 0 0 0 0 0 0 0 0]): file does not exist
                            (open a file, write something, seek to start, read what was written, close the file)
                            data_race_ag_test.go:192: Read([0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]): file does not exist
                            (open a file, write 5 strings, seek to somewhere in the file, read part of what was written, close the file)
                            data_race_ag_test.go:192: Open("b", OpenWrite) = rpc error: code = AlreadyExists desc = file already exists, want <nil>
                            (open a file write-only, close it, open the file read-write, close it, open the file read-only -> fail, try to close the file which failed to open -> fail)
                            data_race_ag_test.go:192: Open("d", OpenReadWrite) = rpc error: code = AlreadyExists desc = file already exists, want <nil>
                            (open a file, write 5 strings, seek to somewhere in the file, read part of what was written, close the file)
                            data_race_ag_test.go:192: Open("a", OpenWrite) = rpc error: code = AlreadyExists desc = file already exists, want <nil>
                            (open a file write-only, close it, open the file read-write, close it, open the file read-only -> fail, try to close the file which failed to open -> fail)
                            data_race_ag_test.go:192: Open("d", OpenReadWrite) = rpc error: code = AlreadyExists desc = file already exists, want <nil>
                            (open a file, write something, seek to start, read what was written, close the file)
                            data_race_ag_test.go:192: Open("c", OpenWrite) = rpc error: code = AlreadyExists desc = file already exists, want <nil>
                            (open a file write-only, close it, open the file read-write, close it, open the file read-only -> fail, try to close the file which failed to open -> fail)
                            data_race_ag_test.go:192: Write([105 115 32]): file does not exist
                            (open a file, write 5 strings, seek to somewhere in the file, read part of what was written, close the file)
                            data_race_ag_test.go:192: Write([98 101 105 110 103 32]): file does not exist
                            (open a file, write 5 strings, seek to somewhere in the file, read part of what was written, close the file)
                            data_race_ag_test.go:192: Seek(-17, 1): file does not exist
                            (open a file, write 5 strings, seek to somewhere in the file, read part of what was written, close the file)
                            data_race_ag_test.go:192: Seek(0, 0): file does not exist
                            (open a file, write something, seek to start, read what was written, close the file)
                            data_race_ag_test.go:192: Open("d", OpenWrite) = rpc error: code = AlreadyExists desc = file already exists, want <nil>
                            (open a file write-only, close it, open the file read-write, close it, open the file read-only -> fail, try to close the file which failed to open -> fail)
                            data_race_ag_test.go:192: Open("c", OpenReadWrite) = rpc error: code = AlreadyExists desc = file already exists, want <nil>
                            (open a file, write something, seek to start, read what was written, close the file)
                            data_race_ag_test.go:192: Open("d", OpenReadWrite) = rpc error: code = AlreadyExists desc = file already exists, want <nil>
                            (open a file write-only, close it, open the file read-write, close it, open the file read-only -> fail, try to close the file which failed to open -> fail)
                            FAIL
                            exit status 1
                            FAIL dat320/lab8/grpcfs/fs 2.772s
                            --- FAIL: TestDataRaceAG (38.37s)
                            === RUN TestConcurrentFileOperationsAG
                            data_race_ag_test.go:195: This test will be run by TestDataRace.
                            --- SKIP: TestConcurrentFileOperationsAG (0.00s)
                            === RUN TestCloseAG
                            === RUN TestCloseAG/readonly_not_exist
                            === RUN TestCloseAG/readonly_existing
                            === RUN TestCloseAG/writeonly
                            === RUN TestCloseAG/writeonly_existing
                            === RUN TestCloseAG/readwrite
                            === RUN TestCloseAG/readwrite_existing
                            TestCloseAG: 6/6 test cases passed
                            --- PASS: TestCloseAG (0.01s)
                            --- PASS: TestCloseAG/readonly_not_exist (0.00s)
                            --- PASS: TestCloseAG/readonly_existing (0.00s)
                            --- PASS: TestCloseAG/writeonly (0.00s)
                            --- PASS: TestCloseAG/writeonly_existing (0.00s)
                            --- PASS: TestCloseAG/readwrite (0.00s)
                            --- PASS: TestCloseAG/readwrite_existing (0.00s)
                            === RUN TestWriteAG
                            === RUN TestWriteAG/noop
                            === RUN TestWriteAG/abc
                            === RUN TestWriteAG/testing
                            === RUN TestWriteAG/write_to_dir
                            === RUN TestWriteAG/textfile
                            === RUN TestWriteAG/utf8
                            TestWriteAG: 6/6 test cases passed
                            --- PASS: TestWriteAG (0.01s)
                            --- PASS: TestWriteAG/noop (0.00s)
                            --- PASS: TestWriteAG/abc (0.00s)
                            --- PASS: TestWriteAG/testing (0.00s)
                            --- PASS: TestWriteAG/write_to_dir (0.00s)
                            --- PASS: TestWriteAG/textfile (0.00s)
                            --- PASS: TestWriteAG/utf8 (0.00s)
                            === RUN TestReadWriteAG
                            === RUN TestReadWriteAG/single_byte
                            === RUN TestReadWriteAG/abc
                            === RUN TestReadWriteAG/testing
                            === RUN TestReadWriteAG/textfile
                            === RUN TestReadWriteAG/utf8
                            === RUN TestReadWriteAG/multiple
                            === RUN TestReadWriteAG/multiple_v2
                            === RUN TestReadWriteAG/eof
                            === RUN TestReadWriteAG/no_write
                            TestReadWriteAG: 9/9 test cases passed
                            --- PASS: TestReadWriteAG (0.02s)
                            --- PASS: TestReadWriteAG/single_byte (0.00s)
                            --- PASS: TestReadWriteAG/abc (0.00s)
                            --- PASS: TestReadWriteAG/testing (0.00s)
                            --- PASS: TestReadWriteAG/textfile (0.00s)
                            --- PASS: TestReadWriteAG/utf8 (0.00s)
                            --- PASS: TestReadWriteAG/multiple (0.00s)
                            --- PASS: TestReadWriteAG/multiple_v2 (0.00s)
                            --- PASS: TestReadWriteAG/eof (0.00s)
                            --- PASS: TestReadWriteAG/no_write (0.00s)
                            === RUN TestReadWriteSeekAG
                            === RUN TestReadWriteSeekAG/seek_to_start_absolute
                            === RUN TestReadWriteSeekAG/seek_to_start_relative
                            === RUN TestReadWriteSeekAG/seek_to_start_from_end
                            === RUN TestReadWriteSeekAG/seek_middle_absolute
                            === RUN TestReadWriteSeekAG/seek_middle_relative
                            === RUN TestReadWriteSeekAG/seek_middle_from_end
                            === RUN TestReadWriteSeekAG/seek_eof
                            === RUN TestReadWriteSeekAG/seek_negative_offset
                            === RUN TestReadWriteSeekAG/seek_check_offset
                            === RUN TestReadWriteSeekAG/seek_overwrite
                            === RUN TestReadWriteSeekAG/seek_fix_typos
                            === RUN TestReadWriteSeekAG/highscore
                            === RUN TestReadWriteSeekAG/read_after_eof
                            TestReadWriteSeekAG: 13/13 test cases passed
                            --- PASS: TestReadWriteSeekAG (0.03s)
                            --- PASS: TestReadWriteSeekAG/seek_to_start_absolute (0.00s)
                            --- PASS: TestReadWriteSeekAG/seek_to_start_relative (0.00s)
                            --- PASS: TestReadWriteSeekAG/seek_to_start_from_end (0.00s)
                            --- PASS: TestReadWriteSeekAG/seek_middle_absolute (0.00s)
                            --- PASS: TestReadWriteSeekAG/seek_middle_relative (0.00s)
                            --- PASS: TestReadWriteSeekAG/seek_middle_from_end (0.00s)
                            --- PASS: TestReadWriteSeekAG/seek_eof (0.00s)
                            --- PASS: TestReadWriteSeekAG/seek_negative_offset (0.00s)
                            --- PASS: TestReadWriteSeekAG/seek_check_offset (0.00s)
                            --- PASS: TestReadWriteSeekAG/seek_overwrite (0.00s)
                            --- PASS: TestReadWriteSeekAG/seek_fix_typos (0.00s)
                            --- PASS: TestReadWriteSeekAG/highscore (0.00s)
                            --- PASS: TestReadWriteSeekAG/read_after_eof (0.00s)
                            === RUN TestMkdirAG
                            === RUN TestMkdirAG/single_dir
                            === RUN TestMkdirAG/subdir_no_parent
                            === RUN TestMkdirAG/duplicate_dir
                            === RUN TestMkdirAG/subdir
                            === RUN TestMkdirAG/3_dirs
                            === RUN TestMkdirAG/nested_dirs
                            === RUN TestMkdirAG/nested_dir_fail_overwrite
                            TestMkdirAG: 7/7 test cases passed
                            --- PASS: TestMkdirAG (0.01s)
                            --- PASS: TestMkdirAG/single_dir (0.00s)
                            --- PASS: TestMkdirAG/subdir_no_parent (0.00s)
                            --- PASS: TestMkdirAG/duplicate_dir (0.00s)
                            --- PASS: TestMkdirAG/subdir (0.00s)
                            --- PASS: TestMkdirAG/3_dirs (0.00s)
                            --- PASS: TestMkdirAG/nested_dirs (0.00s)
                            --- PASS: TestMkdirAG/nested_dir_fail_overwrite (0.00s)
                            === RUN TestOpenAG
                            === RUN TestOpenAG/read_not_exist
                            === RUN TestOpenAG/open_invalid_flag_not_exist
                            === RUN TestOpenAG/open_invalid_flag_exist
                            === CONT TestOpenAG
                            common_test.go:123: failed to serve: grpc: the server has been stopped
                            === RUN TestOpenAG/read_exist
                            === CONT TestOpenAG
                            common_test.go:123: failed to serve: grpc: the server has been stopped
                            === RUN TestOpenAG/write_not_exist
                            === RUN TestOpenAG/write_exist
                            === RUN TestOpenAG/readwrite_not_exist
                            === RUN TestOpenAG/readwrite_exist
                            === RUN TestOpenAG/dir_as_readable
                            === RUN TestOpenAG/dir_as_writeable
                            === RUN TestOpenAG/dir_as_readwriteable
                            TestOpenAG: 11/11 test cases passed
                            --- PASS: TestOpenAG (0.01s)
                            --- PASS: TestOpenAG/read_not_exist (0.00s)
                            --- PASS: TestOpenAG/open_invalid_flag_not_exist (0.00s)
                            --- PASS: TestOpenAG/open_invalid_flag_exist (0.00s)
                            --- PASS: TestOpenAG/read_exist (0.00s)
                            --- PASS: TestOpenAG/write_not_exist (0.00s)
                            --- PASS: TestOpenAG/write_exist (0.00s)
                            --- PASS: TestOpenAG/readwrite_not_exist (0.00s)
                            --- PASS: TestOpenAG/readwrite_exist (0.00s)
                            --- PASS: TestOpenAG/dir_as_readable (0.00s)
                            --- PASS: TestOpenAG/dir_as_writeable (0.00s)
                            --- PASS: TestOpenAG/dir_as_readwriteable (0.00s)
                            === RUN TestLookupAG
                            === RUN TestLookupAG/invalid_path
                            === RUN TestLookupAG/empty_dir
                            === RUN TestLookupAG/empty_file
                            === RUN TestLookupAG/dir_with_file
                            === RUN TestLookupAG/dir_with_dir_and_file
                            === RUN TestLookupAG/dir_with_many_subs
                            === RUN TestLookupAG/dir_with_nested_subdir
                            === RUN TestLookupAG/file_with_content
                            TestLookupAG: 8/8 test cases passed
                            --- PASS: TestLookupAG (0.02s)
                            --- PASS: TestLookupAG/invalid_path (0.00s)
                            --- PASS: TestLookupAG/empty_dir (0.00s)
                            --- PASS: TestLookupAG/empty_file (0.00s)
                            --- PASS: TestLookupAG/dir_with_file (0.00s)
                            --- PASS: TestLookupAG/dir_with_dir_and_file (0.00s)
                            --- PASS: TestLookupAG/dir_with_many_subs (0.00s)
                            --- PASS: TestLookupAG/dir_with_nested_subdir (0.00s)
                            --- PASS: TestLookupAG/file_with_content (0.00s)
                            === RUN TestStreamCipherUsingReaderWriterAG
                            === RUN TestStreamCipherUsingReaderWriterAG/simple_string
                            === RUN TestStreamCipherUsingReaderWriterAG/another_string
                            === RUN TestStreamCipherUsingReaderWriterAG/raw_string
                            === RUN TestStreamCipherUsingReaderWriterAG/utf8
                            === RUN TestStreamCipherUsingReaderWriterAG/file
                            TestStreamCipherUsingReaderWriterAG: 5/5 test cases passed
                            --- PASS: TestStreamCipherUsingReaderWriterAG (0.00s)
                            --- PASS: TestStreamCipherUsingReaderWriterAG/simple_string (0.00s)
                            --- PASS: TestStreamCipherUsingReaderWriterAG/another_string (0.00s)
                            --- PASS: TestStreamCipherUsingReaderWriterAG/raw_string (0.00s)
                            --- PASS: TestStreamCipherUsingReaderWriterAG/utf8 (0.00s)
                            --- PASS: TestStreamCipherUsingReaderWriterAG/file (0.00s)
                            FAIL
                            FAIL dat320/lab8/grpcfs/fs 38.512s
                            === RUN TestCreateAG
                            === RUN TestCreateAG/single_file
                            === RUN TestCreateAG/no_parent_dir
                            === RUN TestCreateAG/duplicate_create
                            === RUN TestCreateAG/file_as_parent_dir
                            === RUN TestCreateAG/3_files
                            TestCreateAG: 5/5 test cases passed
                            --- PASS: TestCreateAG (0.03s)
                            --- PASS: TestCreateAG/single_file (0.01s)
                            --- PASS: TestCreateAG/no_parent_dir (0.00s)
                            --- PASS: TestCreateAG/duplicate_create (0.00s)
                            --- PASS: TestCreateAG/file_as_parent_dir (0.00s)
                            --- PASS: TestCreateAG/3_files (0.00s)
                            === RUN TestServerSideMkdirAG
                            === RUN TestServerSideMkdirAG/single_dir
                            === RUN TestServerSideMkdirAG/subdir_no_parent
                            === RUN TestServerSideMkdirAG/duplicate_dir
                            === RUN TestServerSideMkdirAG/subdir
                            === RUN TestServerSideMkdirAG/3_dirs
                            === RUN TestServerSideMkdirAG/nested_dirs
                            === RUN TestServerSideMkdirAG/nested_dir_fail_overwrite
                            TestServerSideMkdirAG: 7/7 test cases passed
                            --- PASS: TestServerSideMkdirAG (0.02s)
                            --- PASS: TestServerSideMkdirAG/single_dir (0.00s)
                            --- PASS: TestServerSideMkdirAG/subdir_no_parent (0.00s)
                            --- PASS: TestServerSideMkdirAG/duplicate_dir (0.00s)
                            --- PASS: TestServerSideMkdirAG/subdir (0.00s)
                            --- PASS: TestServerSideMkdirAG/3_dirs (0.00s)
                            --- PASS: TestServerSideMkdirAG/nested_dirs (0.00s)
                            --- PASS: TestServerSideMkdirAG/nested_dir_fail_overwrite (0.01s)
                            === RUN TestRemoveAG
                            === RUN TestRemoveAG/rm_file_not_exist
                            === RUN TestRemoveAG/rm_file
                            === RUN TestRemoveAG/rm_dir
                            === RUN TestRemoveAG/rm_subdir
                            === RUN TestRemoveAG/rm_parent_dir
                            === RUN TestRemoveAG/rm_file_within_dir
                            === RUN TestRemoveAG/rm_parent_dir_multiple_files
                            === RUN TestRemoveAG/duplicate_rm_file
                            === RUN TestRemoveAG/duplicate_rm_dir
                            === RUN TestRemoveAG/rm_subdir_replace_with_file
                            TestRemoveAG: 10/10 test cases passed
                            --- PASS: TestRemoveAG (0.01s)
                            --- PASS: TestRemoveAG/rm_file_not_exist (0.00s)
                            --- PASS: TestRemoveAG/rm_file (0.00s)
                            --- PASS: TestRemoveAG/rm_dir (0.00s)
                            --- PASS: TestRemoveAG/rm_subdir (0.00s)
                            --- PASS: TestRemoveAG/rm_parent_dir (0.00s)
                            --- PASS: TestRemoveAG/rm_file_within_dir (0.00s)
                            --- PASS: TestRemoveAG/rm_parent_dir_multiple_files (0.00s)
                            --- PASS: TestRemoveAG/duplicate_rm_file (0.00s)
                            --- PASS: TestRemoveAG/duplicate_rm_dir (0.00s)
                            --- PASS: TestRemoveAG/rm_subdir_replace_with_file (0.00s)
                            === RUN TestServerSideLookupAG
                            === RUN TestServerSideLookupAG/file_not_found
                            === RUN TestServerSideLookupAG/simple_dir
                            === RUN TestServerSideLookupAG/simple_file
                            === RUN TestServerSideLookupAG/subdir
                            === RUN TestServerSideLookupAG/file_in_dir
                            === RUN TestServerSideLookupAG/file_with_content
                            === RUN TestServerSideLookupAG/dir_with_content
                            === RUN TestServerSideLookupAG/deleted_dir
                            === RUN TestServerSideLookupAG/deleted_file
                            === RUN TestServerSideLookupAG/nested_dirs
                            TestServerSideLookupAG: 10/10 test cases passed
                            --- PASS: TestServerSideLookupAG (0.01s)
                            --- PASS: TestServerSideLookupAG/file_not_found (0.00s)
                            --- PASS: TestServerSideLookupAG/simple_dir (0.00s)
                            --- PASS: TestServerSideLookupAG/simple_file (0.00s)
                            --- PASS: TestServerSideLookupAG/subdir (0.00s)
                            --- PASS: TestServerSideLookupAG/file_in_dir (0.00s)
                            --- PASS: TestServerSideLookupAG/file_with_content (0.00s)
                            --- PASS: TestServerSideLookupAG/dir_with_content (0.00s)
                            --- PASS: TestServerSideLookupAG/deleted_dir (0.00s)
                            --- PASS: TestServerSideLookupAG/deleted_file (0.00s)
                            --- PASS: TestServerSideLookupAG/nested_dirs (0.00s)
                            PASS
                            ok dat320/lab8/grpcfs/fsserver 0.078s
                            ? dat320/lab8/grpcfs/proto [no test files]
                            FAIL
                            *** Finished Running Tests in 58 seconds ***
                            """
    
    var body: some View {
        if side == 1{
            ScrollView{
                Text("Bjørn Kristian Teisrud: Lab \(lab.id)")
                    .font(.title)
                    .fontWeight(.bold)
                
                if status == "Approved" {
                    ProgressView(value: scoreValue, total: 100)
                        .accentColor(.blue)
                }else if status == "Rejected"{
                    ProgressView(value: scoreValue, total: 100)
                        .accentColor(.red)
                }else if status == "Revision"{
                    ProgressView(value: scoreValue, total: 100)
                        .accentColor(.orange)
                }else{
                    ProgressView(value: scoreValue, total: 100)
                        .accentColor(.blue)
                }
                        
                        
                Divider()
                VStack{
                    HStack{
                        Spacer()
                        Text("Tests")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        Text("Lab Information")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(width: 250)
                    }
                    HStack{
                        StudentAssignmentTests()
                            .frame(minWidth: 400)
                        Spacer()
                        Divider()
                        StudentAssignmentLabInfo(lab: lab, status: status)
                            .frame(width: 250)
                        
                    }
                    Divider()
                    Text("Feedback")
                        .font(.title2)
                        .fontWeight(.bold)
                    ScrollView{
                        Text(feedback)
                    }
                    .frame(width: .infinity, height: 250)
                }
            }
            .padding()
        }else if side == 2 {
            ScrollView{
                 HStack{
                     VStack{
                         Text("Bjørn Kristian Teisrud: Lab \(lab.id)")
                             .font(.title)
                             .fontWeight(.bold)
                         if status == "Approved" {
                             ProgressView(value: scoreValue, total: 100)
                                 .accentColor(.green)
                         }else if status == "Rejected"{
                             ProgressView(value: scoreValue, total: 100)
                                 .accentColor(.red)
                         }else if status == "Revision"{
                            ProgressView(value: scoreValue, total: 100)
                                .accentColor(.orange)
                        }else{
                             ProgressView(value: scoreValue, total: 100)
                                 .accentColor(.blue)
                         }
                         Divider()
                         Text("Tests")
                             .font(.title2)
                             .fontWeight(.bold)
                         StudentAssignmentTests()
                            .frame(minWidth: 400)
                         Divider()
                         Text("Feedback")
                             .font(.title2)
                             .fontWeight(.bold)
                         ScrollView{
                             Text(feedback)
                         }
                            .frame(width: .infinity, height: 250)
                     }
                     VStack{
                        Text("Lab Information")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        StudentAssignmentLabInfo(lab: lab, status: status)
                        Spacer()
                     }
                     .frame(width: 250)
                 }
             }
             .padding()
        }else if side == 3{
            ScrollView{
                 HStack{
                     VStack{
                         Text("Bjørn Kristian Teisrud: Lab \(lab.id)")
                             .font(.title)
                             .fontWeight(.bold)
                        Divider()
                         if status == "Approved" {
                             ProgressView(value: scoreValue, total: 100)
                                 .accentColor(.green)
                         }else if status == "Rejected"{
                             ProgressView(value: scoreValue, total: 100)
                                 .accentColor(.red)
                         }else if status == "Revision"{
                            ProgressView(value: scoreValue, total: 100)
                                .accentColor(.orange)
                        }else{
                             ProgressView(value: scoreValue, total: 100)
                                 .accentColor(.blue)
                         }
                         Divider()
                         Text("Tests")
                             .font(.title2)
                             .fontWeight(.bold)
                        StudentAssignmentTests()
                           .frame(minWidth: 400)
                         Divider()
                         Text("Feedback")
                             .font(.title2)
                             .fontWeight(.bold)
                         ScrollView{
                             Text(feedback)
                         }
                         .frame(width: .infinity, height: 250)
                     }
                     VStack{
                         Text("Lab Information")
                             .font(.title)
                             .fontWeight(.bold)
                        Divider()
                        StudentAssignmentLabInfo(lab: lab, status: status)
                        Spacer()
                     }
                     .frame(width: 250)
                 }
             }
             .padding()
        }
    }

}

struct StudentLabOverview_Previews: PreviewProvider {
    static var previews: some View {
        StudentLabOverview(lab: AssignmentModel.data[0], side: 3, scoreLimit: 80)
    }
}
