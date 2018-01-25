From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 25 Jan 2018 08:52:21 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 01/10] net: Add a new socket
 option for a future transmit time.
In-Reply-To: <20180125091225.GG1169@localhost>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
 <CAF=yD-JCN483_e9U7tb_4+2jGyWKfhS0TzooOui+kS4Gh7RSqw@mail.gmail.com>
 <20180120020915.erlylrbsaejf7ufo@localhost>
 <20180125091225.GG1169@localhost>
Message-ID: <20180125165221.yl26fa2yieqgkeh4@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jan 25, 2018 at 10:12:25AM +0100, Miroslav Lichvar wrote:
> Do I understand it correctly that no other interface is using
> nanoseconds since 1970? We probably don't have to worry about year
> 2262 yet, but wouldn't it be better to make it consistent with the
> timestamping API using timespec? Or is it just better to avoid the
> 64/32-bit mess of time_t?

I prefer a single 64 bit nanoseconds field:

- Applications won't have to convert to timespec.

- Avoids the time_t issue.

Thanks,
Richard
