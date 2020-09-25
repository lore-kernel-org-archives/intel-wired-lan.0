From: Oron Peled <Oron.Peled@harmonicinc.com>
Date: Fri, 25 Sep 2020 18:52:41 +0000
Subject: [Intel-wired-lan] [EXTERNAL] RE: General question regarding
 i40e driver version in upstream kernel
In-Reply-To: <BYAPR11MB3606ABF2B6ACCB67097C2D32EF390@BYAPR11MB3606.namprd11.prod.outlook.com>
References: <33cb749a85e28598dd19e5041d896775b58fb0e1.camel@harmonicinc.com>
 <BYAPR11MB3606ABF2B6ACCB67097C2D32EF390@BYAPR11MB3606.namprd11.prod.outlook.com>
Message-ID: <a01df73ad3031dce66f44e520ebc11b9caf592dd.camel@harmonicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I'm sorry, but I don't understand how it's related to OSV's:

  *   The latest released upstream kernel is 5.8.11
  *   You can verify it still contain i40e version "2.8.20-k" -- link<https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/ethernet/intel/i40e/i40e_main.c?h=v5.8.11>

  *   Naturally, this is what "bleeding-edge" OSV's take:
     *   Debian/testing (bullseye) use 5.8.0 -- link<https://packages.debian.org/bullseye/linux-image-5.8.0-2-amd64-unsigned>

     *   Ubuntu/groovy use 5.8.0 -- link<https://packages.ubuntu.com/groovy/linux-image-generic>

     *   Fedora use 5.8.11 (even for unreleased yet Fedora-33) -- link<https://src.fedoraproject.org/rpms/kernel>

As Arkady commented below, Intel recommends a much newer driver: 2.12.6
All we wanted to know is why there's such a gap to upstream kernel (not what OSV's take or not)

Also,

  *   In the upcoming kernel 5.9 the version strings were removed from the drivers -- link<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=34a2a3b83e2c>
  *   This would not bother us so much if the latest upstream kernel contained the latest Intel driver.
  *   Regretfully this is not the case, so hiding the version number just add to the existing confusion.

Thanks,

--
Oron Peled

On Thu, 2020-09-24 at 19:54 +0000, Fujinaka, Todd wrote:
Unfortunately, I think the question is why the patches in the upstream kernel don't make it into the OSV kernel quicker and that's a question for the OSV. In this case, Canonical.

I know we've had some delays getting patches into the upstream kernel but we're working on that. Most of the timing issues are due to release schedules and validation as it probably is for your products as well.

Todd Fujinaka
Software Application Engineer
Data Center Group
Intel Corporation
todd.fujinaka at intel.com<mailto:todd.fujinaka@intel.com>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces at osuosl.org<mailto:intel-wired-lan-bounces@osuosl.org>> On Behalf Of Arkady Gilinsky
Sent: Wednesday, September 23, 2020 11:05 PM
To: intel-wired-lan@osuosl.org<mailto:intel-wired-lan@osuosl.org>
Cc: Oron Peled <Oron.Peled at harmonicinc.com<mailto:Oron.Peled@harmonicinc.com>>
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
Intel-wired-lan at osuosl.org<mailto:Intel-wired-lan@osuosl.org>
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200925/91af60fc/attachment-0001.html>
