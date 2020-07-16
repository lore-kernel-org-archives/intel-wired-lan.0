From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 16 Jul 2020 06:39:20 +0200
Subject: [Intel-wired-lan] [bug ?] i40e_rx_buffer_flip should not be
 called for redirected xsk copy mode
In-Reply-To: <7aac955840df438e99e6681b0ae5b5b8@baidu.com>
References: <2863b548da1d4c369bbd9d6ceb337a24@baidu.com>
 <CAJ8uoz08pyWR43K_zhp6PsDLi0KE=y_4QTs-a7kBA-jkRQksaw@mail.gmail.com>
 <7aac955840df438e99e6681b0ae5b5b8@baidu.com>
Message-ID: <CAJ8uoz3Qrh7gTtsOPiz=Z_vHEk+ZoC35cEZ1audDNu5G5pogZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jul 14, 2020 at 1:05 PM Li,Rongqing <lirongqing@baidu.com> wrote:
>
>
>
> > -----????-----
> > ???: Li,Rongqing
> > ????: 2020?7?6? 14:38
> > ???: 'Magnus Karlsson' <magnus.karlsson@gmail.com>
> > ??: intel-wired-lan <intel-wired-lan@lists.osuosl.org>; Bj?rn T?pel
> > <bjorn.topel@intel.com>; Karlsson, Magnus <magnus.karlsson@intel.com>;
> > Netdev <netdev@vger.kernel.org>
> > ??: ??: [Intel-wired-lan] [bug ?] i40e_rx_buffer_flip should not be called
> > for redirected xsk copy mode
> >
> >
> >
> > > -----????-----
> > > ???: Magnus Karlsson [mailto:magnus.karlsson at gmail.com]
> > > ????: 2020?7?6? 14:13
> > > ???: Li,Rongqing <lirongqing@baidu.com>
> > > ??: intel-wired-lan <intel-wired-lan@lists.osuosl.org>; Bj?rn T?pel
> > > <bjorn.topel@intel.com>; Karlsson, Magnus <magnus.karlsson@intel.com>;
> > > Netdev <netdev@vger.kernel.org>
> > > ??: Re: [Intel-wired-lan] [bug ?] i40e_rx_buffer_flip should not be
> > > called for redirected xsk copy mode
> > >
> > > Thank you RongQing for reporting this. I will take a look at it and
> > > produce a patch.
> > >
> > > /Magnus
> >
>
> Ping

My apologies RongQing, but it is taking longer than expected due to
key people being on vacation during this summer period. We are
debating weather the simple fix you provided covers all cases.
Hopefully it does, but we just want to make sure. The fix is needed in
four drivers: the ones you mention plus ice.

/Magnus

>
> -Li
