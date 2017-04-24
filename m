From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 24 Apr 2017 10:23:48 +0200
Subject: [Intel-wired-lan] [PATCH 1/2] e1000e: Don't return
 uninitialized stats
In-Reply-To: <20170421212012.25950-1-bpoirier@suse.com>
References: <20170421212012.25950-1-bpoirier@suse.com>
Message-ID: <71d8032d-5ed1-8242-83e6-16ce65718966@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Benjamin,


Thank you for your fix.

On 04/21/17 23:20, Benjamin Poirier wrote:
> Some statistics passed to ethtool are garbage because e1000e_get_stats64()
> doesn't write them, for example: tx_heartbeat_errors. This leaks kernel
> memory to userspace and confuses users.

Could you please give specific examples to reproduce the issue? That way 
your fix can also be tested.

[?]


Kind regards,

Paul
