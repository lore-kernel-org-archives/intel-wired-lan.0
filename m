From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 10 Jun 2021 11:07:24 -0700
Subject: [Intel-wired-lan] [PATCH net v1] igb: Fix position of
 assignment to *ring
In-Reply-To: <20210611224217.94872-1-jedrzej.jagielski@intel.com>
References: <20210611224217.94872-1-jedrzej.jagielski@intel.com>
Message-ID: <878s3hvbj7.fsf@vcostago-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

J?drzej Jagielski <jedrzej.jagielski@intel.com> writes:

> Assignment to *ring should be done after correctness check of the
> argument queue.
>
> Fixes: 91db364236c8 ("igb: Refactor igb_configure_cbs()")
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


-- 
Vinicius
