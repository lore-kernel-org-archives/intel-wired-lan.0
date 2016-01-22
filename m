From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 21 Jan 2016 16:07:20 -0800
Subject: [Intel-wired-lan] [next, S23,
 06/13 v2] i40e/i40evf: tunnels can be generic
In-Reply-To: <CAKgT0Ueubf1ex4C2=avpPHgPVUAnRY4F6JZJyecvXqufHA2Etg@mail.gmail.com>
References: <1453329824-9465-1-git-send-email-jesse.brandeburg@intel.com>
 <CAKgT0Ueubf1ex4C2=avpPHgPVUAnRY4F6JZJyecvXqufHA2Etg@mail.gmail.com>
Message-ID: <20160121160720.00000e23@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 20 Jan 2016 23:25:28 -0800
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> > -       if (!(tx_flags & I40E_TX_FLAGS_UDP_TUNNEL)) {
> > +       if ((tx_flags & I40E_TX_FLAGS_TUNNEL)) {
> 
> You only need one set of parenthesis here instead of two since you
> have flipped the logic.  Otherwise the rest of the patch looks fine.

Thanks, v3 sent.
