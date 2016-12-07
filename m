From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 7 Dec 2016 23:24:28 +0000
Subject: [Intel-wired-lan] [PATCH] igb: reset the PHY before reading the
 PHY	ID
In-Reply-To: <1589605144.308560.1480435436440.JavaMail.zimbra@xes-inc.com>
References: <1589605144.308560.1480435436440.JavaMail.zimbra@xes-inc.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81FE7D3D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Aaron Sierra
> Sent: Tuesday, November 29, 2016 8:04 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Chris Arges <carges@vectranetworks.com>; intel-wired-lan <intel-wired-
> lan at lists.osuosl.org>; Matwey V. Kornilov <matwey@sai.msu.ru>
> Subject: [Intel-wired-lan] [PATCH] igb: reset the PHY before reading the PHY
> ID
> 
> Several people have reported firmware leaving the I210/I211 PHY's page
> select register set to something other than the default of zero. This
> causes the first accesses, PHY_IDx register reads, to access something
> else, resulting in device probe failure:
> 
>     igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
>     igb: Copyright (c) 2007-2014 Intel Corporation.
>     igb: probe of 0000:01:00.0 failed with error -2
> 
> This problem began for them after a previous patch I submitted was
> applied:
> 
>     commit 2a3cdead8b408351fa1e3079b220fa331480ffbc
>     Author: Aaron Sierra <asierra@xes-inc.com>
>     Date:   Tue Nov 3 12:37:09 2015 -0600
> 
>         igb: Remove GS40G specific defines/functions
> 
> I personally experienced this problem after attempting to PXE boot from
> I210 devices using this firmware:
> 
>     Intel(R) Boot Agent GE v1.5.78
>     Copyright (C) 1997-2014, Intel Corporation
> 
> Resetting the PHY before reading from it, ensures the page select
> register is in its default state and doesn't make assumptions about
> the PHY's register set before the PHY has been probed.
> 
> Cc: Matwey V. Kornilov <matwey@sai.msu.ru>
> Cc: Chris Arges <carges@vectranetworks.com>
> Cc: Jochen Henneberg <jh@henneberg-systemdesign.com>
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
