From: David Miller <davem@davemloft.net>
Date: Sun, 31 May 2015 21:46:13 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH] ethernet/intel: Use setup_timer
In-Reply-To: <20150601044349.GA4730@vaishali-Ideapad-Z570>
References: <20150601044349.GA4730@vaishali-Ideapad-Z570>
Message-ID: <20150531.214613.1488046829950588850.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vaishali Thakkar <vthakkar1994@gmail.com>
Date: Mon, 1 Jun 2015 10:13:49 +0530

> Use the timer API function setup_timer instead of structure field
> assignments to initialize a timer.
> 
> A simplified version of the Coccinelle semantic patch that performs
> this transformation is as follows:
> 
> @change@
> expression e1, e2, e3, e4, a, b;
> @@
> 
> -init_timer(&e1);
> +setup_timer(&e1, a, b);
> 
> ... when != a = e2
>     when != b = e3
> 
> -e1.function = a;
> ... when != b = e4
> -e1.data = b;
> 
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>

Applied, thanks.
