From: zhuyj <zyjzyj2000@gmail.com>
Date: Tue, 15 Mar 2016 14:12:06 +0800
Subject: [Intel-wired-lan] [E1000-devel] i40e card Tx resets
In-Reply-To: <20160314214333.GP5084@oracle.com>
References: <20160314214333.GP5084@oracle.com>
Message-ID: <56E7A7B6.5030209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I have the similar problem. Would you like to make tests with pktgen tools?
Maybe the test result is not related with tso.

Zhu Yanjun

On 03/15/2016 05:43 AM, Sowmini Varadhan wrote:
> Hi,
>
> I am trying out some DB stress tests on both i40e and ixgbe. The
> stress test that I use is rds-stress (http://linux.die.net/man/1/rds-stress),
> and I can list out the entire set of steps and parameters that I
> am using to run this if that info is  interesting.
>
> My test bed is a pair of X5-2 (Haswell) servers, each with a
> Niantic (X540-AT2) card and a Fortville card. The Niantic/fortville
> cards are connected back-to-back, so I essentially have a 10G
> connection and a 40G connection.
>
> Everything else (kernel, RDS modules, stress test and parameters)
> remaining the same, I get  the expected throughput on the 10G
> connection, but the i40e connection goes through a lot of TX
> errors that result in console messages like this:
>
>    i40e 0000:81:00.0: TX driver issue detected, PF reset issued
>    i40e 0000:81:00.0 eth2: adding 68:05:ca:30:db:30 vid=0
>    i40e 0000:81:00.0: TX driver issue detected, PF reset issued
>    i40e 0000:81:00.0 eth2: VSI_seid 390, Hung TX queue 32, tx_pending: 82, NTC:0xeb, HWB: 0xeb, NTU: 0x13d, TAIL: 0x13d
>    i40e 0000:81:00.0 eth2: VSI_seid 390, Issuing force_wb for TX queue 32, Interrupt Reg
>
> I understand these are "mdd errors", but how can I find out what
> triggered these errors, any hints?
>
> The other data-point here is that if I disable tso, and fall back
> to gso, there are no tx errors, and throughput matches the 10G
> connection (for the same set of test parameters).
>
> Please let me know if there is any other info that would help.
> The kernel is a 4.5.0-rc2 kernel. Info for the i40e card is
>
>      # ethtool -i eth3
>      driver: i40e
>      version: 1.4.8-k
>      firmware-version: 5.02 0x80002285 0.0.0
>      bus-info: 0000:81:00.1
>         :
>
> Thanks in advance,
> --Sowmini
>
> ------------------------------------------------------------------------------
> Transform Data into Opportunity.
> Accelerate data analysis in your applications with
> Intel Data Analytics Acceleration Library.
> Click to learn more.
> http://pubads.g.doubleclick.net/gampad/clk?id=278785231&iu=/4140
> _______________________________________________
> E1000-devel mailing list
> E1000-devel at lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/e1000-devel
> To learn more about Intel&#174; Ethernet, visit http://communities.intel.com/community/wired

