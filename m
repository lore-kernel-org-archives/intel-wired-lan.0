From: Williams, Mitch A <mitch.a.williams@intel.com>
Date: Thu, 17 Mar 2016 17:36:34 +0000
Subject: [Intel-wired-lan] Latest dev-queue pull has i40e VFs reporting
 "Device still in reset"
In-Reply-To: <CAKgT0UcjLtV8Xgco2KJ6aNPNOEEezNA+2axnT-uSH0Jx3kc+Ew@mail.gmail.com>
References: <CAKgT0Ue=36RUVBkDJ0scqCwFEph8JOJmBqaD2MiY+CDvj3mpuQ@mail.gmail.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99D5B1@ORSMSX104.amr.corp.intel.com>
 <CAKgT0UffsuRkqLb6iMZbsHQm14_UpyqFZBZJ8bq7jS706oiSCw@mail.gmail.com>
 <CAKgT0UcjLtV8Xgco2KJ6aNPNOEEezNA+2axnT-uSH0Jx3kc+Ew@mail.gmail.com>
Message-ID: <AAEA33E297BCAC4B9BB20A7C2DF0AB8D78567E7E@FMSMSX113.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We should have patches to fix this problem coming out today.
-Mitch

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, March 16, 2016 2:01 PM
> To: Bowers, AndrewX <andrewx.bowers@intel.com>
> Cc: e1000-devel at lists.sourceforge.net; intel-wired-lan <intel-wired-
> lan at lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] Latest dev-queue pull has i40e VFs reporting
> "Device still in reset"
> 
> So I updated to the latest firmware:
> firmware-version: 5.02 0x80002284 0.0.0
> 
> Same result.  I can reload the driver and I get different VFs failing
> to come up.
> 
> - Alex
> 
> On Wed, Mar 16, 2016 at 11:26 AM, Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> > Well what I am seeing seems to be an intermittent issue, though I am
> > having no problem spawning 7 VFs which is my default environment.
> >
> > My setup is just loading the PF driver, enabling SR-IOV, reloading the
> > VF driver, and bringing up the PFs and VFs in separate namespaces.
> > Sometimes it is working without any errors, but the majority of the
> > time I am seeing the messages about "Device is still in reset"
> > repeating and eventually scrolling of the screen.
> >
> > I'm not completely sure if my firmware is current.  Output from
> > "ethtool -i" is included below just in case this might be a firmware
> > thing and I need to update:
> > driver: i40e
> > version: 1.5.1-k
> > firmware-version: 4.26 0x8000152d 0.0.0
> > bus-info: 0000:02:00.0
> > supports-statistics: yes
> > supports-test: yes
> > supports-eeprom-access: yes
> > supports-register-dump: yes
> > supports-priv-flags: yes
> >
> > - Alex
> >
> > On Wed, Mar 16, 2016 at 11:12 AM, Bowers, AndrewX
> > <andrewx.bowers@intel.com> wrote:
> >> I'm not seeing the reset, but I get a permission denied error trying to
> echo 4 to /sys/class/net/[device]/device/sriov_numvfs and an ls of the
> directory shows no sriov_numvfs file present... I can do it with my ixgbe
> device, but not my i40e device.  I went back to a few different kernels from
> earlier this week, last week, and the week before with the same results.
> Since I know it WAS working earlier, I tried the stock kernel and get "no
> such file or directory"... I'm thinking it's an issue with my card, although
> I wonder if yours is related. I'll try a few things with mine and see if I
> get anywhere.
> >>
> >>> -----Original Message-----
> >>> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org]
> On
> >>> Behalf Of Alexander Duyck
> >>> Sent: Wednesday, March 16, 2016 10:21 AM
> >>> To: e1000-devel at lists.sourceforge.net; intel-wired-lan <intel-wired-
> >>> lan at lists.osuosl.org>
> >>> Subject: [Intel-wired-lan] Latest dev-queue pull has i40e VFs reporting
> >>> "Device still in reset"
> >>>
> >>> So my system with the latest pull of the dev-queue branch is stuck
> reporting
> >>> "Device is still in reset (-16), retrying" for one or more VFs after I
> reload the
> >>> drivers.  I've been trying to bisect the issue but haven't been having
> much
> >>> luck.
> >>>
> >>> Just wanted to see if anyone in Intel was aware of the issue, otherwise
> I will
> >>> probably re-run my bisection with a full system reset between patches as
> I
> >>> suspect I may be having issues reproducing it due to stray data being
> left in
> >>> from earlier driver loads.
> >>>
> >>> - Alex
> >>> _______________________________________________
> >>> Intel-wired-lan mailing list
> >>> Intel-wired-lan at lists.osuosl.org
> >>> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
