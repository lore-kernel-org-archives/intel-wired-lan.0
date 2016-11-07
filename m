From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 7 Nov 2016 10:42:25 -0800
Subject: [Intel-wired-lan] i40e performance regression after 1.3.9 ?
In-Reply-To: <9f9f62ec-fbce-534a-d2bd-e918a03a3899@isc.org>
References: <9f9f62ec-fbce-534a-d2bd-e918a03a3899@isc.org>
Message-ID: <CAKgT0Uc9W_tvMEoKzLzBG-pK7Sjznr3B+xgjne0tUuTX17d+Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Nov 7, 2016 at 8:47 AM, Ray Bellis <ray@isc.org> wrote:
> Does anyone have any ideas on the performance regression I've reported
> on the i40e at https://sourceforge.net/p/e1000/bugs/544/ ?
>
> I've got code that with the 1.3.9 driver and kernel 4.3 can achieve 1.3
> million packets per second, but if I drop in 1.3.38 or later it drops to
> about 500k.
>
> This regression affects off-the-shelf DNS server software packages too.
>
> thanks,
>
> Ray Bellis
> ISC Research Fellow

Do you know if the packets are being dropped in the Rx path or is the
bottleneck on the Tx side?  It looks like this could be one of a few
things.  Doing a quick git log and git diff between v4.3 and v4.4 the
two things that jump out at me are changes to the Tx tail bumping code
and changes to the interrupt moderation code.

To narrow this down you might try manually configuring both the 1.3.9
and 1.3.38 drivers to the same interrupt moderation values using a
command like:
ethtool -C <iface> adaptive-rx off adaptive-tx off rx-usecs 25 tx-usecs 25

That would default the interrupt moderation to somewhere around 40K
interrupts per second.  If you run this command on both drivers and
they give you the same performance than we would know that the issue
is likely due to changes in the dynamic interrupt moderation.

Thanks.

- Alex
