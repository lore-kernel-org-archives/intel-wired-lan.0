From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 15 Jun 2016 08:20:57 -0700
Subject: [Intel-wired-lan] [PATCH net] ixgbe: napi_poll must return the
	work done
In-Reply-To: <37ccedd746ed932b9d73eff592f324f2a3fc6c6f.1465995724.git.pabeni@redhat.com>
References: <37ccedd746ed932b9d73eff592f324f2a3fc6c6f.1465995724.git.pabeni@redhat.com>
Message-ID: <CAKgT0UeU7tfo=i5O1j9ORwBJUVYGta5Z-NLw+xKGVLeHQ=PPtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jun 15, 2016 at 6:37 AM, Paolo Abeni <pabeni@redhat.com> wrote:
> Currently the function ixgbe_poll() returns 0 when it clean completely
> the rx rings, but this foul budget accounting in core code.
> Fix this returning the actual work done, capped to weight - 1, since
> the core doesn't allow to return the full budget when the driver modifies
> the napi status
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

I think the origin of reporting 0 was actually compatibility with some
NAPI code floating around from before the 2.6.24 kernel.

I'd be curious to know how much this is actually fouling things up.
Can you point to any specific issues it was causing?  If you end up
having to submit a v2 for any reason it might be useful if you can
provide the additional details on what actual issue it was causing.

You might also want to look at the other Intel drivers, specifically
ixgbevf and fm10k as I believe we have similar code in those drivers
as well.

Acked-by: Alexander Duyck <aduyck@mirantis.com>
