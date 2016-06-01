From: Christoph Hellwig <hch@infradead.org>
Date: Wed, 1 Jun 2016 00:59:56 -0700
Subject: [Intel-wired-lan] [PATCH 5/5] ethernet: Use
	pci_(request|release)_mem_regions
In-Reply-To: <3f24b687c31dea31a03cd3a529de790e942dd5bb.1464694724.git.jthumshirn@suse.de>
References: <cover.1464694724.git.jthumshirn@suse.de>
 <3f24b687c31dea31a03cd3a529de790e942dd5bb.1464694724.git.jthumshirn@suse.de>
Message-ID: <20160601075956.GD11923@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 31, 2016 at 02:05:13PM +0200, Johannes Thumshirn wrote:
> Now that we do have pci_request_mem_regions() and pci_release_mem_regions() at
> hand, use it in the ethernet drivers.

This should probably be one patch per driver.
