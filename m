From: Wen Chiu <Wen.Chiu@brocade.com>
Date: Thu, 10 Sep 2015 22:19:08 +0000
Subject: [Intel-wired-lan] stopping 10GC(x540T2) port does not down the link
Message-ID: <1df36b45bac44d719d55b7ab71e4d422@Hq1wp-exmb11.corp.brocade.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi DKDK maintainers,

We are seeing an issue where if a port is shutdown in linux using "ip link set <dev> down" command on baremetal. Then use "ip link show" to show the port which got shutdown which is in DOWN state as expected. But, the port on the other end still shows UP state which should be DOWN. Following is the excerpt from DKDK notes which indicates the similar issue with 40G. But, we are seeing the problem with 10GC(x540T2) adapter. Could you confirm this? It would be highly appreciated if you could shed some lights regarding this issue, fixes or workaround.

Attached has the screen traces to show how to create and show the issue using "ip link".  Eth8 and Eth9 are directly connected. Eth8 is the interface that got disabled/down via admin. Eth9 is the other end which should be down but is still UP and hence the issue. Attached also has output for "lspci -vv" in that device 42:00.0 is eth8 and 42:00.1 is eth9.

PS. ixgbe_dev_stop() is called but looks phy is not turn off is it is copper. I did see laser tx is turned off if it is fiber.

Thanks,
Wen Chiu

6.24. Stopping the port does not down the link on Intel(r) 40G Ethernet controller
Description:
On Intel(r) 40G Ethernet Controller stopping the port does not really down the port link.
Implication:
The port link will be still up after stopping the port.
Resolution/Workaround:
None
Affected Environment/Platform:
All.
Driver/Module:
Poll Mode Driver (PMD).


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150910/704bf06b/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: output
Type: application/octet-stream
Size: 56948 bytes
Desc: output
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150910/704bf06b/attachment-0001.obj>
