From: Wen Chiu <Wen.Chiu@brocade.com>
Date: Sat, 12 Sep 2015 00:28:02 +0000
Subject: [Intel-wired-lan] stopping 10GC(x540T2) port does not down the
 link
In-Reply-To: <E16520E5-76F9-4589-9C2E-6F31040635FF@intel.com>
References: <1df36b45bac44d719d55b7ab71e4d422@Hq1wp-exmb11.corp.brocade.com>
 <E16520E5-76F9-4589-9C2E-6F31040635FF@intel.com>
Message-ID: <f3ac35bec8024ccc8e6bfc86e71170dc@Hq1wp-exmb11.corp.brocade.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Mark,

Thanks for your prompted response. First of all, let me clarify the issue. The issue was first seen with our vRouter running DPDK. To isolate it, we setup a Ubuntu 13.4 based baremetal box to try the same and the issue was also seen. So, it is now genuine linux (driver?) issue.

I did try what you suggest and used ethtool to see the eth8 status below. Both ports are already set to "d".
wen at wen-PowerEdge-R620:~$ sudo ethtool eth8 |grep Wake
        Supports Wake-on: d
        Wake-on: d
wen at wen-PowerEdge-R620:~$ sudo ethtool eth9 |grep Wake
        Supports Wake-on: d
        Wake-on: d

After I administratively disable eth8, eth9 (the other end of the connected port) still shows UP. Any other ideas? Please let me know.

Thanks,
Wen Chiu

-----Original Message-----
From: Rustad, Mark D [mailto:mark.d.rustad at intel.com] 
Sent: Friday, September 11, 2015 9:17 AM
To: Wen Chiu
Cc: Kirsher, Jeffrey T; Brandeburg, Jesse; Nelson, Shannon; Wyborny, Carolyn; Skidmore, Donald C; Vick, Matthew; Ronciak, John; Williams, Mitch A; intel-wired-lan at lists.osuosl.org; Stephen Hemminger
Subject: Re: [Intel-wired-lan] stopping 10GC(x540T2) port does not down the link

Wen Chiu,

> On Sep 10, 2015, at 3:19 PM, Wen Chiu <Wen.Chiu@brocade.com> wrote:
> 
> Hi DKDK maintainers,

I assume that you are referring to DPDK. I am not aware of any DPDK maintainers on this mailing list, though there could be.

> We are seeing an issue where if a port is shutdown in linux using ?ip link set <dev> down? command on baremetal. Then use ?ip link show? to show the port which got shutdown which is in DOWN state as expected. But, the port on the other end still shows UP state which should be DOWN. Following is the excerpt from DKDK notes which indicates the similar issue with 40G. But, we are seeing the problem with 10GC(x540T2) adapter. Could you confirm this? It would be highly appreciated if you could shed some lights regarding this issue, fixes or workaround.

Although I do not know the internals of DPDK, something general to look at is whether Wake-On-LAN is enabled. Ethtool can show you the state. If it reports anything other than d, then it is enabled and that will prevent the phy from powering down. You should be able to change the WOL setting using the command:
	ethtool -s eth8 wol d

You would want to do that for each port that you want to be able to power down administratively. This is all kind of assuming that the DPDK driver supports these operations, which I do not know, but WOL is the first thing that I think of to check.

--
Mark Rustad, Networking Division, Intel Corporation

