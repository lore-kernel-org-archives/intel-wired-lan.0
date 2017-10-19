From: Pavlos Parissis <pavlos.parissis@gmail.com>
Date: Fri, 20 Oct 2017 01:02:59 +0200
Subject: [Intel-wired-lan] Instability of i40e driver on 4.9 kernel
Message-ID: <92118fc4-8a20-f129-193b-9c8fdf81aa24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

We have been running 4.9 kernels for several months on CentOS 7.3 and for few weeks on CentOS 7.4,
and, after we replaced 10GbE cobber cards(X540-AT2 with ixgbe driver) with X710 10GbE SFP cards
using i40e driver, we noticed sever instabilities on our servers.

On several servers the links were marked down and up again, without any obvious reasons expect a lot
of errors on kernel.log. We run Bird Internet daemon on our servers in order to establish BGP
peerings with routers and we have observed flapping on BGP peerings. At the same time we had BGP
peering stabilities issues we had kernel errors. We decided to go back to 3.10 kernel from CentOS,
but that process wasn't smooth as latest firmware gave us problems with speed detection. We rolled
back to two version old and speed detection issue was resolved. We have been running 3.10 several
weeks without any problems. Even we want certain functionality from kernel 4.9, we decided to switch
back to 3.10 as stability of our systems has higher priority.

I need to mention that in all occurrences of the issue we didn't see any anomalies, such DDOS
attacks and etc.

I have opened https://communities.intel.com/message/501682#501682 and there you can find all the
error messages and other information.

Since we noticed the issues, I have been following netdev ML and I know that there are a lot of
improvements/patched queued up for 4.14 and I am hoping those patches fix our issue and most
importantly are sent to linux-stable for inclusion in 4.9 kernel.

Cheers,
Pavlos


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171020/5c41f224/attachment.asc>
