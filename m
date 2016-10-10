From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Date: Mon, 10 Oct 2016 15:31:00 +0300
Subject: [Intel-wired-lan] igb driver can cause cache invalidation of
	non-owned memory?
In-Reply-To: <f75cf1e1-d7e8-e044-188a-987f05f321a5@cogentembedded.com>
References: <0b57cbe2-84f7-6c0a-904a-d166571234b5@cogentembedded.com>
 <20161010.050125.1981283393312167625.davem@davemloft.net>
 <10474d19-df1a-3b09-917e-70659be3a56c@cogentembedded.com>
 <20161010.075731.2449861168238706.davem@davemloft.net>
 <f75cf1e1-d7e8-e044-188a-987f05f321a5@cogentembedded.com>
Message-ID: <21f40aaf-c7e5-c9a0-0ce3-e5ff187ee07e@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>> All the data has been synced
> 
> Non-synced data is write done by CPU executing upper layers of network stack,

Upper layers shall never get area that is still dma_map()ed and will be
dma_unmap()ed in future.  But with igb, this is exactly what happens.
