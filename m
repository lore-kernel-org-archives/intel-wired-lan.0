From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Sat, 12 Sep 2015 00:54:48 +0000
Subject: [Intel-wired-lan] stopping 10GC(x540T2) port does not down the
 link
In-Reply-To: <f3ac35bec8024ccc8e6bfc86e71170dc@Hq1wp-exmb11.corp.brocade.com>
References: <1df36b45bac44d719d55b7ab71e4d422@Hq1wp-exmb11.corp.brocade.com>
 <E16520E5-76F9-4589-9C2E-6F31040635FF@intel.com>
 <f3ac35bec8024ccc8e6bfc86e71170dc@Hq1wp-exmb11.corp.brocade.com>
Message-ID: <C97FC248-54C0-4458-82EB-ED894C7437F7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Wen Chiu,

> On Sep 11, 2015, at 5:28 PM, Wen Chiu <Wen.Chiu@brocade.com> wrote:
> 
> Thanks for your prompted response. First of all, let me clarify the issue. The issue was first seen with our vRouter running DPDK. To isolate it, we setup a Ubuntu 13.4 based baremetal box to try the same and the issue was also seen. So, it is now genuine linux (driver?) issue.

Ah. Ok. Can you tell me what the kernel version is on Ubuntu 13.4? I just checked and found that code to control the phy power did not get into the kernel driver until kernel version 4.2.

> I did try what you suggest and used ethtool to see the eth8 status below. Both ports are already set to "d".
> wen at wen-PowerEdge-R620:~$ sudo ethtool eth8 |grep Wake
>        Supports Wake-on: d
>        Wake-on: d
> wen at wen-PowerEdge-R620:~$ sudo ethtool eth9 |grep Wake
>        Supports Wake-on: d
>        Wake-on: d

Yup. WOL is disabled.

> After I administratively disable eth8, eth9 (the other end of the connected port) still shows UP. Any other ideas? Please let me know.

As I indicated above, the kernel driver did not get code to control phy power until version 4.2. The out-of-tree Source Forge driver got that code earlier, so it is in the current version posted there. You could try installing that driver and see if it works for you if that is easier than getting to the 4.2 kernel.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150912/251592c0/attachment.asc>
