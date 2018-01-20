From: Richard Cochran <richardcochran@gmail.com>
Date: Fri, 19 Jan 2018 18:09:15 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 01/10] net: Add a new socket
 option for a future transmit time.
In-Reply-To: <CAF=yD-JCN483_e9U7tb_4+2jGyWKfhS0TzooOui+kS4Gh7RSqw@mail.gmail.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
 <CAF=yD-JCN483_e9U7tb_4+2jGyWKfhS0TzooOui+kS4Gh7RSqw@mail.gmail.com>
Message-ID: <20180120020915.erlylrbsaejf7ufo@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 19, 2018 at 04:15:46PM -0500, Willem de Bruijn wrote:
> > +               if (cmsg->cmsg_len != CMSG_LEN(sizeof(ktime_t)))
> > +                       return -EINVAL;
> 
> I don't see any existing reference to ktime_t in include/uapi. Just use a s64?

Agreed.  I didn't see the point of switching to ktime, either.

Thanks,
Richard
