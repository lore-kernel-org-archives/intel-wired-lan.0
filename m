From: Xiaomeng Tong <xiam0nd.tong@gmail.com>
Date: Thu,  3 Mar 2022 16:38:31 +0800
Subject: [Intel-wired-lan] [PATCH 2/6] treewide: remove using list
 iterator after loop body as a ptr
In-Reply-To: <20220303083007.11640-1-xiam0nd.tong@gmail.com>
References: <20220303083007.11640-1-xiam0nd.tong@gmail.com>
Message-ID: <20220303083831.11833-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

correct for typo:

-for (struct list_head *list = head->next, cond = (struct list_head *)-1; cond == (struct list_head *)-1; cond = NULL) \
+for (struct list_head *list = head->next, *cond = (struct list_head *)-1; cond == (struct list_head *)-1; cond = NULL) \

--
Xiaomeng Tong
