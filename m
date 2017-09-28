From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Thu, 28 Sep 2017 23:27:54 +0000
Subject: [Intel-wired-lan] i40e MDD events
In-Reply-To: <CAOZ2QJPbOrGLoZWnZUY268owFsFxFq-UcdYLbUn1Kf7tzE9oHg@mail.gmail.com>
References: <CAOZ2QJPbOrGLoZWnZUY268owFsFxFq-UcdYLbUn1Kf7tzE9oHg@mail.gmail.com>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B6265A15909B@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Dan Streetman
> Sent: Thursday, September 28, 2017 1:53 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; Duyck, Alexander H
> <alexander.h.duyck@intel.com>
> Subject: [Intel-wired-lan] i40e MDD events
> 
> Hi, I'm from Canonical support, and I have reports from an Ubuntu user
> seeing MDD events occurring on a i40e nic, from the PF (not a VF)
> while using the Ubuntu 4.4 kernel.  I found two commits that I thought
> addressed this problem, but they did not help - the reporter still is
> seeing MDD events, which reset the PF for every MDD event.  The
> commits I thought fixed this, which have been added but still don't
> fix the MDD events, are:
> 

Hello Dan,

What is the firmware version on the device?  ethtool -i output or dmesg log should provide it.  I believe the device needs a fw update.   They are available  on our download center here:  https://downloadcenter.intel.com/download/24769
A fw update will usually require a driver update as well, but the fw version info from the user will help with this determination.

Thanks,

Carolyn

Carolyn Wyborny 
Linux Development 
Networking Division 
Intel Corporation 


