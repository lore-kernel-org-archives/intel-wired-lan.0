From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Fri, 11 Sep 2015 16:16:30 +0000
Subject: [Intel-wired-lan] stopping 10GC(x540T2) port does not down the
 link
In-Reply-To: <1df36b45bac44d719d55b7ab71e4d422@Hq1wp-exmb11.corp.brocade.com>
References: <1df36b45bac44d719d55b7ab71e4d422@Hq1wp-exmb11.corp.brocade.com>
Message-ID: <E16520E5-76F9-4589-9C2E-6F31040635FF@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

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

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150911/24d66115/attachment-0001.asc>
