From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 22 Oct 2015 07:01:01 -0600
Subject: [Intel-wired-lan] [Qemu-devel] [RFC Patch 00/12] IXGBE: Add
 live migration support for SRIOV NIC
In-Reply-To: <20151022123252.GA19940@redhat.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
 <CAJ3xEMiStMJdGjgO9=MQrhLpBo8ZiTRoOL_P=aC9kyrNi91FSw@mail.gmail.com>
 <1445455227.4059.867.camel@redhat.com> <20151022123252.GA19940@redhat.com>
Message-ID: <1445518861.4059.869.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2015-10-22 at 15:32 +0300, Michael S. Tsirkin wrote:
> On Wed, Oct 21, 2015 at 01:20:27PM -0600, Alex Williamson wrote:
> > The trouble here is that the VF needs to be unplugged prior to the start
> > of migration because we can't do effective dirty page tracking while the
> > device is connected and doing DMA.
> 
> That's exactly what patch 12/12 is trying to accomplish.
> 
> I do see some problems with it, but I also suggested some solutions.

I was replying to:

> So... what would you expect service down wise for the following
> solution which is zero touch and I think should work for any VF
> driver:

And then later note:

"Here it's done via an enlightened guest driver."

