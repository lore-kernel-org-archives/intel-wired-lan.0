From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 6 Oct 2020 16:56:43 +0000
Subject: [Intel-wired-lan] [EXTERNAL] RE: General question regarding
 i40e driver version in upstream kernel
In-Reply-To: <ab2e8db6ad05a4a293cd63be0753632e3f3b0ce3.camel@harmonicinc.com>
References: <33cb749a85e28598dd19e5041d896775b58fb0e1.camel@harmonicinc.com>
 <BYAPR11MB3606ABF2B6ACCB67097C2D32EF390@BYAPR11MB3606.namprd11.prod.outlook.com>
 <a01df73ad3031dce66f44e520ebc11b9caf592dd.camel@harmonicinc.com>
 <DM6PR11MB2890E25E8E6896966CA36522BC360@DM6PR11MB2890.namprd11.prod.outlook.com>
 <ab2e8db6ad05a4a293cd63be0753632e3f3b0ce3.camel@harmonicinc.com>
Message-ID: <DM6PR11MB28900350EA31F2846AB72362BC0D0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Oron,

Sorry for the delayed response.  As an organization we do attempt to keep the in kernel driver code in sync with the downloadable driver, but that is not always possible.

I?m only peripherally involved with the i40e driver and cannot speak to specifics, but in general terms the differences can be due to something being implemented in a different way from one form of the driver to the next (yes we should fix those cases) other times it is due to having an implementation or feature in the out of tree driver that is not acceptable to the kernel community.  In the former case any functional differences should be viewed and reported as bugs.  The later case?  Report it anyway and push us to come up with a solution that is acceptable to the community at large.

For most use cases I believe the driver differences fall into the category of probably OK with a bit of YMMV (and bug us when mileage varies to keep us honest.)  If you need a feature where our implementation is at odds with the kernel community it may swing towards the ?forget about it? end of the spectrum, but even then bug us about it.  The division is going to be more likely to put effort into something if people are demanding it.

Thanks,
Aaron Brown

From: Oron Peled <Oron.Peled@harmonicinc.com>
Sent: Friday, September 25, 2020 4:15 PM
To: Arkady Gilinsky <arkady.gilinsky@harmonicinc.com>; Fujinaka, Todd <todd.fujinaka@intel.com>; intel-wired-lan at osuosl.org; Brown, Aaron F <aaron.f.brown@intel.com>
Subject: Re: [EXTERNAL] RE: General question regarding i40e driver version in upstream kernel

Hi,

Thanks Aaron, it means latest out of tree driver and latest upstream kernel may not be as "distanced" as appeared initially -- it's somewhat encouraging.

Still, we try to assess using in-tree drivers, both now and more important -- down the road:

  *   Our use-cases may be considered bleeding-edge (DPDK and all that jazz)
  *   We try to bump our DPDK every year or so (e.g: testing 20.08.0)
  *   How far in-tree drivers from meeting such criteria? Is it "forget it"? Or "probably OK, YMMV" ?

I've just did a stupid "diff" of "i40e" from upstream kernel "v5.9-rc6" and version 2.6.12 downloaded from Intel (ignoring "kcompat*" files):

$ diff -Nru --exclude kcompat\* ~1 . | diffstat

 Makefile             |  186 -

 Module.supported     |    1

 common.mk            |  348 --

 i40e.h               |  411 ---

 i40e_adminq.c        |  302 +-

 ...

 i40e_lan_hmc.h       |    2

 i40e_main.c          | 6115 +++++++++++++++++++++------------------------------

 i40e_nvm.c           |  315 +-

 ...

 i40e_xsk.c           |  608 +++++

 i40e_xsk.h           |   23

 virtchnl.h           |  959 -------

 45 files changed, 6732 insertions(+), 23518 deletions(-)

I cannot say I'm very happy about this -- do I miss something? Is there some light at the end of this tunnel?

Thank you for answering. I'm not shooting any messengers, just trying to understand the current and possible future state.

--
Oron Peled

On Fri, 2020-09-25 at 20:31 +0000, Brown, Aaron F wrote:
Unfortunately the driver versioning in the kernel does not really map to the versioning in the ?out of tree? (download-able) driver.  If you look at the git history for the i40e driver you will see regular patches to the driver with very few of those patches touching the version string, so that string in the kernel is not a very good indicator of what code that driver contains.

The current upstream kernel has done away with the driver string in place of the kernel version itself instead, which is probably a better indication of the actual driver.

From: Intel-wired-lan <intel-wired-lan-bounces at osuosl.org<mailto:intel-wired-lan-bounces@osuosl.org>> On Behalf Of Oron Peled
Sent: Friday, September 25, 2020 11:53 AM
To: Arkady Gilinsky <arkady.gilinsky at harmonicinc.com<mailto:arkady.gilinsky@harmonicinc.com>>; Fujinaka, Todd <todd.fujinaka at intel.com<mailto:todd.fujinaka@intel.com>>; intel-wired-lan at osuosl.org<mailto:intel-wired-lan@osuosl.org>
Subject: Re: [Intel-wired-lan] [EXTERNAL] RE: General question regarding i40e driver version in upstream kernel

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201006/9e4c7952/attachment-0001.html>
