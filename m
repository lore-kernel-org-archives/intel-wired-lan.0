From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 1 Feb 2018 05:16:02 +0100
Subject: [Intel-wired-lan] [RFC v2 net-next 01/10] net: Add a new socket
 option for a future transmit time.
In-Reply-To: <8e77a23e-d8f8-78ee-f681-0aa689ba3d22@intel.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
 <20180118084227.GL1175@localhost>
 <20180118171335.bhyl76wobdffedho@localhost>
 <8e77a23e-d8f8-78ee-f681-0aa689ba3d22@intel.com>
Message-ID: <20180201041601.qovxelzmsox7opsf@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 31, 2018 at 04:49:36PM -0800, Jesus Sanchez-Palencia wrote:
> While implementing this today it crossed my mind that why don't we have the
> clockid_t set per socket (e.g. as an argument to SO_TXTIME) instead of per packet?

Sounds good to me.

Thanks,
Richard
