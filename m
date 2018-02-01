From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Thu, 1 Feb 2018 10:27:26 +0100
Subject: [Intel-wired-lan] [RFC v2 net-next 01/10] net: Add a new socket
 option for a future transmit time.
In-Reply-To: <8e77a23e-d8f8-78ee-f681-0aa689ba3d22@intel.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
 <20180118084227.GL1175@localhost>
 <20180118171335.bhyl76wobdffedho@localhost>
 <8e77a23e-d8f8-78ee-f681-0aa689ba3d22@intel.com>
Message-ID: <20180201092726.GH10203@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 31, 2018 at 04:49:36PM -0800, Jesus Sanchez-Palencia wrote:
> On 01/18/2018 09:13 AM, Richard Cochran wrote:
> > Right, the clockid_t should be passed in through the CMSG along with
> > the time.
> 
> While implementing this today it crossed my mind that why don't we have the
> clockid_t set per socket (e.g. as an argument to SO_TXTIME) instead of per packet?

I suspect that might have an impact on the performance. Even if the
application doesn't use sendmmsg(), it would possibly have to call
setsockopt() before each sendmsg() to change the clockid_t, right?

If clockid_t could be set per packet, a special value could be used
to allow sending on interfaces that don't support it.

> The only use-case that we could think of that would be 'blocked' was using
> sendmmsg() to send a packet to different interfaces with a single syscall, but
> I'm not sure how common that is.

The SO_TXTIME option will make sendmmsg() useful in applications where
it wasn't before. For instance, an NTP server will be able to batch
multiple responses as their transmit timestamps can be set accurately
in advance and it's no longer necessary to send the responses as soon
as they are assembled.

I think it would be nice the sendmmsg() calls didn't have to be split
by clockid_t.

-- 
Miroslav Lichvar
