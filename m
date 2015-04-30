From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 30 Apr 2015 20:52:07 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: Update ITR scaling mechanism
 based on PCIe link speed
In-Reply-To: <55419187.9040900@redhat.com>
References: <1430352634-25084-1-git-send-email-jacob.e.keller@intel.com>
 <55419187.9040900@redhat.com>
Message-ID: <1430427126.25212.6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-04-29 at 19:20 -0700, Alexander Duyck wrote:
> 
> On 04/29/2015 05:10 PM, Jacob Keller wrote:
> > Red Rock Canyon's interrupt throttle timers are based on the PCIe link
> > speed. Because of this, the value being programmed into the ITR
> > registers must be scaled.
> >
> > For the PF, this is as simple as reading the PCIe link speed and storing
> > the result. However, in the case of SR-IOV, the VF's interrupt throttle
> > timers are based on the link speed of the PF. However, the VF is unable
> > to get the link speed information from its configuration space, so the
> > PF must inform it of what scale to use.
> >
> > Rather than pass this scale via mailbox message, take advantage of
> > unused bits in the TDLEN register to pass the scale. It is the
> > responsibility of the PF to program this for the VF while setting up the
> > VF queues and the responsibility of the VF to get the information
> > accordingly. This is preferable because it allows the VF to set up the
> > interrupts properly during initialization and matches how the MAC
> > address is passed in the TDBAL/TDBAH registers.
> >
> > These changes also resolve an issue with the existing ITR scale being
> > too restrictive. It would throttle down to 1300ints/s at 1538 byte
> > frames. This patch modifies the algorithm to allow for a higher range of
> > interrupts per second, from roughly 25000int/s up to 100000int/s
> > depending on our detection of the workload.
> >
> > This patch fixes a single receiving TCP_STREAM in netperf:
> > - Before: 450 Mbps
> > - After: 20,000 Mbps
> >
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > Discovered-by: Matthew Vick <matthew.vick@intel.com>
> 
> Should probably be Reported-by, since I don't think Discovered-by is a 
> standard convention.
> 
> Also I don't think I see any of the changes I suggested.  It seems like 
> this could still divide the interrupt throttle rate all the way down to 0.

I'm going to defer this for a bit then, since it depends on other
changes I wasn't aware of.. Matthew?

Regards,
Jake
