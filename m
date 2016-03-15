From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 15 Mar 2016 06:54:33 -0400
Subject: [Intel-wired-lan] [E1000-devel] i40e card Tx resets
In-Reply-To: <56E7CE18.9020004@gmail.com>
References: <20160314214333.GP5084@oracle.com> <56E7A7B6.5030209@gmail.com>
 <56E7CE18.9020004@gmail.com>
Message-ID: <20160315105433.GC11063@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On (03/15/16 16:55), zhuyj wrote:
> Sorry. I explain this in details.
> I have an similar problem. At first, I think it is related with tso.
> Then I made tests with pktgen tools and found that this similar
> problem still occurred whether
> tso is enabled or not.
> 
> So I suggest to make tests with pktgen tools to exclude tso.
> 

I realize that TSO might not be the root cause (Tushar also
pointed that out) but might just be triggering the issue...

I dont think we need pktgen at this point- it's quite easy
to reproduce this on commodity Haswell servers, and by installing
the rds-stress from the rpm below:

http://public-yum.oracle.com/repo/OracleLinux/OL6/ofed_UEK/x86_64//getPackageSource/rds-tools-2.0.7-1.12.el6.src.rpm

To run it, set up 2 nodes  connected on i40e. I shall call them
"client" and "server" though both will send traffic in the test

Start the listener:
 server# modprobe rds-tcp
 server# rds-stress -r <server addr>

Start the test:

 client# modprobe rds-tcp
 client# rds-stress -r <client addr> -s <server-addr> -q 256 -a 8192 -d16 -t16 -T30 

(all params are explained in the rds-stress man page)

If you do this on ixgbe, you will see that the column for "tx+rx K/s"
shows a steady throughput, whereas i40e numbers are bursty and low.

Also, for i40e, you will see messages about TX hang on on the console.

I think that, to find the root-cause, we need to see what is
triggering the mdd error.

Would be good if someone from Intel could provide some hints on
how to do that (or try the above tests!)

--Sowmini
