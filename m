From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 3 Mar 2020 08:00:27 -0800
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove copper fiber
 switch control
In-Reply-To: <549bd226-b5fa-eb68-44a5-f77dcaf28c5a@intel.com>
References: <20200302202307.23260-1-sasha.neftin@intel.com>
 <CAKgT0UdFW1KbAzsUX2o7-UDD1ay70euxs6Ts=RjYN4dfFEE6Fg@mail.gmail.com>
 <549bd226-b5fa-eb68-44a5-f77dcaf28c5a@intel.com>
Message-ID: <CAKgT0Uc-nbt+8+gbNWabWrA0xZrUFqBtvUWNiNNpKMD-XhCCKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Mar 2, 2020 at 4:44 PM Neftin, Sasha <sasha.neftin@intel.com> wrote:
>
> On 3/2/2020 13:26, Alexander Duyck wrote:
> > On Mon, Mar 2, 2020 at 12:23 PM Sasha Neftin <sasha.neftin@intel.com> wrote:
> >>
> >> i225 device support copper mode only
> >> PHY signal detect indication for copper fiber switch
> >> not applicable to i225 part
> >>
> >> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> >
> > So there are a couple issues with this patch.
> >
> > All the changes in igc_ethtool.c are broken at this point. Once a
> > register is defined in regs_buff you cannot change it. Otherwise you
> > cannot debug this in the future. You would be better off just skipping
> > the register that you were storing CONNSW and let it default to zero
> > instead of doing all of the shifting you are doing. You can just skip
> > over the register in the dump in ethtool assuming there is even a file
> > for the device that hasbeen added.
> >
> This change not affected igc_ethtool.c behavior. I see the same behavior
> on my setup.
> Actually ethtool --register-dump not called (as properly).get_regs
> callback from igc_ethtool.c. This is not related to this patch and I
> need investigate and fix it.
> ethtool --register-dump <adapter> show me row generic data. Data is
> really from i225 registers, but not parcered as for other drivers.
>

Right. It isn't implemented yet, but you don't want to break it. The
logic for the register dump assumes the register locations are fixed.
So once you released this the first time you cannot move the registers
around. You can drop registers or add registers, but once they are in
the list they are permanently in that position. If you don't do that
you will never be able to decode the data.

- Alex
