From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Mon, 7 Nov 2016 16:55:08 +0000
Subject: [Intel-wired-lan] tx hang,
 server reboot with driver igb under load
In-Reply-To: <plop87vaweasr3.fsf@aoskar.kilobug.org>
References: <plop87vaweasr3.fsf@aoskar.kilobug.org>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD65AD1F530@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sorry if no one has responded to this. The e1000-devel mailing list would've been a better place for this.

Looking at your logs, I see that Gandalf has a 3.5b BIOS and doesn't list as many details as Buffy. I would ask Supermicro about the BIOS versions as a first step.

Todd Fujinaka
Software Application Engineer
Networking Division (ND)
Intel Corporation
todd.fujinaka at intel.com
(503) 712-4565


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Gael Le Mignot
Sent: Thursday, October 27, 2016 5:20 AM
To: intel-wired-lan@lists.osuosl.org
Cc: gael at pilotsystems.net; paulj at pilotsystems.net; David Sapiro <david@pilotsystems.net>
Subject: [Intel-wired-lan] tx hang, server reboot with driver igb under load

Hello,


Summary of the problem

We have had a few crash under network load on production servers using the igb network driver. Those crashes are not very frequent (a couple of times per year at most) but very disrupting when they happen on production servers.


The setup

Hardware :
- SuperMicro servers
- Dual AMD Opteron
- Network card integrated in motherboard :
  Intel Corporation 82576 Gigabit Network Connection

Software stack is :
- Xen hypervisor (4.4.1)
- Debian GNU/Linux stable - Jessie (8.x)
- Linux 3.16.0-4 (Debian?s package)
  Integrated igb driver (5.0.5-k)

In addition we use the following technologies :
- DRBD for disk replication ;
- taged vlans ;
- ethernet bridges.

Those servers being currently used in production, additional testing might be complicated.


Symptoms

Occasionally, the following events occur :
- timeout on DRBD : 
  [22020289.869016] block drbd7: Remote failed to finish a request within ko-count * timeout
- followed by a tx hang: 
  [22020294.529389] igb 0000:02:00.0: Detected Tx Unit Hang
- followed by an attempt to reset network adapter : 
  [22020301.536766] igb 0000:02:00.0 eth0: Reset adapter
  [22020304.674250] igb 0000:02:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
- but the problem persists  :
  [22020306.530956] igb 0000:02:00.0: Detected Tx Unit Hang
- after a couple of similar cycles, the server reboots.


What we tried

We tried the following operations, which didn?t solve the problem :
- upgrading the kernel to 4.1.0-0.bpo.2 (igp version 5.2.15-k) ;
- replacing the embedded network card by an external one (which uses the same driver) :
  Intel Corporation I350 Gigabit Network Connection

We tried to temporarily remove one of the servers from the datacenter to perform stress testing, but we couldn?t reproduce the crash outside real-world operations.


Additional informations

Other similar, but slightly older, servers don?t seem to exhibit the same issue.

We uploaded additional information to http://www-in.pilotsystems.net/igp/ :
- the full logs of last crash/reboot ;
- lspci -v, ethtool -i, ethtool -k, dmidecode on a server with
  the issue (gandalf) and another one that seems fine (buffy)

Regards,

--
Ga?l Le Mignot - gael at pilotsystems.net
Pilot Systems - 82, rue de Pix?r?court - 75020 Paris Tel : +33 1 44 53 05 55 - www.pilot-systems.net G?rez vos contacts et vos newsletters : www.cockpit-mailing.com _______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
