From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Jan 2021 23:17:06 +0100
Subject: [Intel-wired-lan] [PATCH net-next v1 1/2] net: core: count
 drops from GRO
In-Reply-To: <0e06ff3234b78b5bde6bf77d192a42c3f8ab5319.camel@kernel.org>
References: <20210106215539.2103688-1-jesse.brandeburg@intel.com>
 <20210106215539.2103688-2-jesse.brandeburg@intel.com>
 <1e4ee1cf-c2b7-8ba3-7cb1-5c5cb3ff1e84@pensando.io>
 <20210108102630.00004202@intel.com>
 <c11bb25a-f73d-3ae9-b1fd-7eb96bc79cc7@pensando.io>
 <0e06ff3234b78b5bde6bf77d192a42c3f8ab5319.camel@kernel.org>
Message-ID: <CANn89iK_yMC2LbA0N+=U3JACAGhciuLpQ_uCa3qZ1_fUbWCyUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 8, 2021 at 9:27 PM Saeed Mahameed <saeed@kernel.org> wrote:
>

> I think there is still some merit in this patchset even with Eric's
> removal of GRO_DROP from gro_receive(). As Eric explained, it is still
> possible to silently drop for the same reason when drivers
> call napi_get_frags or even alloc_skb() apis, many drivers do not
> account for such packet drops, and maybe it is the right thing to do to
> inline the packet drop accounting into the skb alloc APIs ? the
> question is, is it the job of those APIs to update netdev->stats ?
>

You absolutely do not want to have a generic increment of
netdev->stats for multiqueue drivers.
This would add terrible cache line false sharing under DDOS and memory stress.

Each driver maintains (or should maintain) per rx queue counter for this case.

It seems  mlx4 does nothing special, I would suggest you fix it :)
