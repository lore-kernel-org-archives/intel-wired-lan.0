From: David Miller <davem@davemloft.net>
Date: Wed, 24 Jul 2019 11:14:35 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next v2 0/8] Use dev_get_drvdata
 where possible
In-Reply-To: <20190724060512.23899-1-hslester96@gmail.com>
References: <20190724060512.23899-1-hslester96@gmail.com>
Message-ID: <20190724.111435.1790922345411569346.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Chuhong Yuan <hslester96@gmail.com>
Date: Wed, 24 Jul 2019 14:05:12 +0800

> These patches use dev_get_drvdata instead of
> using to_pci_dev + pci_get_drvdata to make
> code simpler where possible.
> 
> Changelog:
> 
> v1 -> v2:
> - Change pci_set_drvdata to dev_set_drvdata
>   to keep consistency.

Some of these patches were applied yesterday, weren't they?

Please take that into consideration when you repost, especially
when the maintainer(s) explicitly reply to your patches saying
"Applied." or similar like I always do.

Thanks.
