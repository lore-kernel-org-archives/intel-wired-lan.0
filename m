From: Jiri Benc <jbenc@redhat.com>
Date: Wed, 15 Sep 2021 08:40:22 +0200
Subject: [Intel-wired-lan] [PATCH net] i40e: fix endless loop under rtnl
In-Reply-To: <b94eb5b1-04b7-a1ba-3040-a8f35d40f426@intel.com>
References: <4d94f7fbd9dd6476c5adc8967f3db84bc9204f47.1630319620.git.jbenc@redhat.com>
 <b94eb5b1-04b7-a1ba-3040-a8f35d40f426@intel.com>
Message-ID: <20210915084009.4260d7ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 14 Sep 2021 16:37:55 -0700, Jesse Brandeburg wrote:
> The fix seems fine to me on initial review.
> you can add my
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Thanks!

> but...
> Missing Fixes: tag?

I should have added that, yes. I sent a v2 yesterday with the tag
included,

https://patchwork.kernel.org/project/netdevbpf/patch/452ff4ddfef7fc8f558a8c8eb7a8050688760e11.1631609537.git.jbenc at redhat.com/

Could you reply with your Reviewed-by to that one? Alternatively, I can
send a v3.

Thanks,

 Jiri

