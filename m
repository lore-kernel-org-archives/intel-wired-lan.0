From: Jia-Ju Bai <baijiaju1990@163.com>
Date: Wed, 05 Aug 2015 20:34:24 +0800
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Modify tx/rx
 configurations to avoid null pointer dereferences in e1000_open
In-Reply-To: <1438771429.3467.28.camel@intel.com>
References: <1438769770-8887-1-git-send-email-baijiaju1990@163.com>
 <1438771429.3467.28.camel@intel.com>
Message-ID: <55C202D0.3050003@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 08/05/2015 06:43 PM, Jeff Kirsher wrote:
>
> Is your intention that this patch replace the existing patch:
> http://patchwork.ozlabs.org/patch/502990/
> ...which is currently in my queue?
>

Okay, please replace the previous patch.

