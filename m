From: Fan Du <fengyuleidian0615@gmail.com>
Date: Tue, 07 Apr 2015 09:52:23 +0800
Subject: [Intel-wired-lan] [E1000-devel] Fragmented UDP packets trigger
 rx_missed_errors on 82599EB
In-Reply-To: <87618083B2453E4A8714035B62D679925028D5FC@FMSMSX105.amr.corp.intel.com>
References: <551CBDE3.30708@gmail.com>
 <87618083B2453E4A8714035B62D679925028D5FC@FMSMSX105.amr.corp.intel.com>
Message-ID: <55233857.80803@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

? 2015?04?03? 01:52, Tantilov, Emil S ??:
>> >
>> ># numactl --hardware
>> >available: 4 nodes (0-3)
>> >node 0 cpus: 0 1 2 3 4 20 21 22 23 24
>> >node 0 size: 24466 MB
>> >node 0 free: 22444 MB
>> >node 1 cpus: 5 6 7 8 9 25 26 27 28 29
>> >node 1 size: 16384 MB
>> >node 1 free: 15831 MB
>> >node 2 cpus: 10 11 12 13 14 30 31 32 33 34
>> >node 2 size: 16384 MB
>> >node 2 free: 15791 MB
>> >node 3 cpus: 15 16 17 18 19 35 36 37 38 39
>> >node 3 size: 24576 MB
>> >node 3 free: 22508 MB
>> >node distances:
>> >node 0 1 2 3
>> >0: 10 21 31 31
>> >1: 21 10 31 31
>> >2: 31 31 10 21
>> >3: 31 31 21 10
> Since you have 4 nodes you may want to check your board layout and try to pin the queues and iperf to the same
>   node as the network interface. See if that helps.

Thanks for the hints.

UDP is used here, so it actually doesn't matter to tie iperf server on the same core for receiving the flow.
I didn't launch iperf server, only running iperf client to send *fragmented* UDP packets.
On the server side, still ifconfig shows dropped packets increasing, and ethtool -S confirmed with
rx_missed_errors also climbing.

Client: iperf -c SEVER_IP -u  -b 10G -i 1 -t 100000 -P 12 -l 30k

Server:
kernel: 4.0.0-rc4 , when buffer size(-l) >= 30k, no rx_missed_errors
                     when buffer size(-l) <  30k, confirmed rx_missed_errors

Server:
kernel: 2.6.32-358 , when buffer size(-l) >= 10k, no rx_missed_errors
                      when buffer size(-l) <  10k, confirmed rx_missed_errors

Any suggestions?

> If you want to debug your numa allocations in more detail, check out this tool:
> http://www.intel.com/software/pcm

-- 
????????????????
????????????????
