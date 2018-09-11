From: Benjamin Poirier <benjamin.poirier@gmail.com>
Date: Tue, 11 Sep 2018 17:31:47 +0900
Subject: [Intel-wired-lan] e1000e driver stuck at 10Mbps after
 reconnection
In-Reply-To: <20180907062851.GA7336@super_plancton>
References: <20180806115913.GA21556@super_plancton>
 <CAKgT0UcUV8bQRAhyevfnvwE+yWnWjwAkH0WumUoUK4Fa9SCzhg@mail.gmail.com>
 <20180807064222.GA30741@super_plancton>
 <001556a4-c49c-b96b-0be8-b3c4be7bb09c@intel.com>
 <c1e2cf13-6bcc-498d-03ea-7c3792d675cb@intel.com>
 <20180907062851.GA7336@super_plancton>
Message-ID: <20180911083147.GA31642@f2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/09/07 08:28, Camille Bordignon wrote:
> Le mercredi 08 ao?t 2018 ? 18:00:28 (+0300), Neftin, Sasha a ?crit :
> > On 8/8/2018 17:24, Neftin, Sasha wrote:
> > > On 8/7/2018 09:42, Camille Bordignon wrote:
> > > > Le lundi 06 ao?t 2018 ? 15:45:29 (-0700), Alexander Duyck a ?crit :
> > > > > On Mon, Aug 6, 2018 at 4:59 AM, Camille Bordignon
> > > > > <camille.bordignon@easymile.com> wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > Recently we experienced some issues with intel NIC (I219-LM
> > > > > > and I219-V).
> > > > > > It seems that after a wire reconnection, auto-negotation "fails" and
> > > > > > link speed drips to 10 Mbps.
> > > > > > 
[...]
> 
> I recently figured out that neither the previous patch nor commit
> 0b76aae741abb9d16d2c0e67f8b1e766576f897d fix this issue.
> 
> In these cases, after reproducing the issue, when ethernet wire is connected
> kernel logs mention full speed (1000 Mbps) but actually it seems it is not.
> The problem persists.
> 

Hmm, so the newer (post 4110e02eb45e) kernels are actually "better", in
that they accurately report that link speed is 10Mb/s.

In the end, do you know of a kernel version that doesn't exhibit the
problem of slower actual link speed?

I had a look at the code and I tried to reproduce the problem on the
hardware that I have (I217) but could not.

Also, out of curiosity, have you tried playing with the speed, autoneg
and advertise settings via ethtool -s to force the link to 1000Mb/s?
