From: David Miller <davem@davemloft.net>
Date: Thu, 30 Apr 2020 20:29:24 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix error return code
 in ice_add_prof()
In-Reply-To: <20200427121228.12241-1-weiyongjun1@huawei.com>
References: <20200427121228.12241-1-weiyongjun1@huawei.com>
Message-ID: <20200430.202924.285425895831692651.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Mon, 27 Apr 2020 12:12:28 +0000

> Fix to return a error code from the error handling case
> instead of 0, as done elsewhere in this function.
> 
> Fixes: 31ad4e4ee1e4 ("ice: Allocate flow profile")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied, thanks.
