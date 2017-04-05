From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 05 Apr 2017 12:53:14 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Allow to remove administratively
 set MAC on VFs
In-Reply-To: <20170405091327.GA4988@calimero.vinschen.de>
References: <20170404151055.21447-1-vinschen@redhat.com>
 <B1C1DF2ACD01FD4881736AA51731BAB2B1E1A2@ORSMSX107.amr.corp.intel.com>
 <CAKgT0UdYjzk4worxwfpuCEY7c6+n8x1Uqz5_=Az_y1zeK6gCSg@mail.gmail.com>
 <20170405091327.GA4988@calimero.vinschen.de>
Message-ID: <CAKgT0UdHbfSL-5QM6sfH=j7adQLAscUss1GzN2oYZsLM1CgV3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Apr 5, 2017 at 5:13 AM Corinna Vinschen <vinschen@redhat.com> wrote:

> Hi Alex,
>
> On Apr  4 10:33, Alexander Duyck wrote:
> > On Tue, Apr 4, 2017 at 10:16 AM, Duyck, Alexander H
> > <alexander.h.duyck@intel.com> wrote:
> > >> -----Original Message-----
> > >> From: Intel-wired-lan [mailto:
> intel-wired-lan-bounces at lists.osuosl.org] On
> > >> Behalf Of Corinna Vinschen
> > >> Sent: Tuesday, April 4, 2017 8:11 AM
> > >> To: intel-wired-lan at lists.osuosl.org
> > >> Cc: netdev at vger.kernel.org
> > >> Subject: [Intel-wired-lan] [PATCH] igb: Allow to remove
> administratively set MAC
> > >> on VFs
> > >> [...]
> >
> > So I just realized there is one other minor issue I just found. In
> > igb_rar_set_qsel you should probably add a check for
> > "is_valid_ether_addr(addr)" before you set the E1000_RAH_AV bit. For
> > the zeroed MAC address it should be cleared so that we aren't
> > filtering on a MAC address of all 0's for the VF.
> >
> > - Alex
>
> I see your point, but I'm a bit reluctant to do that because
> igb_vf_configure() calls igb_set_vf_mac() with addr set to the
> zeroed MAC explicitely:
>
>
>   eth_zero_addr(mac_addr);
>   igb_set_vf_mac(adapter, vf, mac_addr);
>
> So in this case the zero MAC is already treated as valid address
> and the E1000_RAH_AV bit is set.  Is that just a bug?
>
>
> Corinna
>
Yes, that would be a bug. We shouldn't be treatin all 0's as a valid
address.

- Alex
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170405/57325131/attachment.html>
