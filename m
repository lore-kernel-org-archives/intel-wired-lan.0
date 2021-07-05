From: Toke =?unknown-8bit?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 05 Jul 2021 19:06:26 +0200
Subject: [Intel-wired-lan] [PATCH v2 intel-next 0/4] XDP_TX improvements
 for ice
In-Reply-To: <20210705164338.58313-1-maciej.fijalkowski@intel.com>
References: <20210705164338.58313-1-maciej.fijalkowski@intel.com>
Message-ID: <87sg0sy9kd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Hi,
>
> this is a second revision of a series around XDP_TX improvements for ice
> driver. When compared to v1 (which can be found under [1]), two new
> patches are introduced that are focused on improving the performance for
> XDP_TX as Jussi reported that the numbers were pretty low on his side.
> Furthermore the fallback path is now based on static branch, as
> suggested by Toke on v1. This means that there's no further need for a
> standalone net_device_ops that were serving the locked version of
> ndo_xdp_xmit callback.
>
> Idea from 2nd patch is borrowed from a joint work that was done against
> OOT driver among with Sridhar Samudrala, Jesse Brandeburg and Piotr
> Raczynski, where we working on fixing the scaling issues for Tx AF_XDP
> ZC path.
>
> Last but not least, with this series I observe the improvement of
> performance by around 30%.

Wow, "but not least" indeed! :D
You can't just drop that at the end like that! I want details -
whaddyamean, "by around 30%"? In all cases? Only for TX? Gimme numbers! :)

-Toke

