From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Sat, 21 Oct 2017 00:07:23 +0000
Subject: [Intel-wired-lan] Instability of i40e driver on 4.9 kernel
In-Reply-To: <92118fc4-8a20-f129-193b-9c8fdf81aa24@gmail.com>
References: <92118fc4-8a20-f129-193b-9c8fdf81aa24@gmail.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD697A3FFD1@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

You picked a bunch of places to post this, and you really should've used a different place: e1000-devel at lists.sourceforge.net

Also, since you flagged the "communities" post as "answered", you're not likely to get any follow-up. The Intel communities are also not monitored as much by the wired networking people at Intel.

Please let us know if you have any specific issues, and please provide exact reproduction steps so we can investigate your issues, and please use e1000-devel.

Todd Fujinaka
Software Application Engineer
Datacenter Engineering Group
Intel Corporation
todd.fujinaka at intel.com


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Pavlos Parissis
Sent: Thursday, October 19, 2017 4:03 PM
To: netdev@vger.kernel.org; intel-wired-lan at lists.osuosl.org
Subject: [Intel-wired-lan] Instability of i40e driver on 4.9 kernel

Hi all,

We have been running 4.9 kernels for several months on CentOS 7.3 and for few weeks on CentOS 7.4, and, after we replaced 10GbE cobber cards(X540-AT2 with ixgbe driver) with X710 10GbE SFP cards using i40e driver, we noticed sever instabilities on our servers.

On several servers the links were marked down and up again, without any obvious reasons expect a lot of errors on kernel.log. We run Bird Internet daemon on our servers in order to establish BGP peerings with routers and we have observed flapping on BGP peerings. At the same time we had BGP peering stabilities issues we had kernel errors. We decided to go back to 3.10 kernel from CentOS, but that process wasn't smooth as latest firmware gave us problems with speed detection. We rolled back to two version old and speed detection issue was resolved. We have been running 3.10 several weeks without any problems. Even we want certain functionality from kernel 4.9, we decided to switch back to 3.10 as stability of our systems has higher priority.

I need to mention that in all occurrences of the issue we didn't see any anomalies, such DDOS attacks and etc.

I have opened https://communities.intel.com/message/501682#501682 and there you can find all the error messages and other information.

Since we noticed the issues, I have been following netdev ML and I know that there are a lot of improvements/patched queued up for 4.14 and I am hoping those patches fix our issue and most importantly are sent to linux-stable for inclusion in 4.9 kernel.

Cheers,
Pavlos


