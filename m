From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Thu, 24 Sep 2020 19:54:02 +0000
Subject: [Intel-wired-lan] General question regarding i40e driver
 version in upstream kernel
In-Reply-To: <33cb749a85e28598dd19e5041d896775b58fb0e1.camel@harmonicinc.com>
References: <33cb749a85e28598dd19e5041d896775b58fb0e1.camel@harmonicinc.com>
Message-ID: <BYAPR11MB3606ABF2B6ACCB67097C2D32EF390@BYAPR11MB3606.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Unfortunately, I think the question is why the patches in the upstream kernel don't make it into the OSV kernel quicker and that's a question for the OSV. In this case, Canonical.

I know we've had some delays getting patches into the upstream kernel but we're working on that. Most of the timing issues are due to release schedules and validation as it probably is for your products as well.

Todd Fujinaka
Software Application Engineer
Data Center Group
Intel Corporation
todd.fujinaka at intel.com

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Arkady Gilinsky
Sent: Wednesday, September 23, 2020 11:05 PM
To: intel-wired-lan@osuosl.org
Cc: Oron Peled <Oron.Peled@harmonicinc.com>
Subject: [Intel-wired-lan] General question regarding i40e driver version in upstream kernel

Hi All,

I have a general question related to i40e driver in Linux kernel.
In latest Ubuntu-20.04 release (Focal) with kernel 5.4.0-42-generic the standard i40e driver is quite old (2.8.20-k), while on Intel official site recently was announced newer i40e (2.12.6).
Also, the latest upstream kernel is 5.8.3 has the same (2.8.20-k) version of i40e driver.
See here: https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/intel/i40e/i40e_main.c#L28

Could, anybody from driver maintainers, clarify why there is such a big gap in versions of i40e driver.
Do all the drivers, from 2.8.20-k version, not stable enough, so they were not taken into kernel upstream?

--
Best regards,
Arkady Gilinsky

------------------------------------------

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
