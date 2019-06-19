From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Jun 2019 23:29:58 +0000
Subject: [Intel-wired-lan] [next-queue,
 v2] fm10k: add missing field initializers to TLV attributes)
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3F8D88@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>From: Jacob Keller <jacob.e.keller@intel.com>
>To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
>Date: Tue, 19 Feb 2019 14:26:27 -0800
>Message-Id: <20190219222627.28699-1-jacob.e.keller@intel.com>
>X-Mailer: git-send-email 2.18.0.219.gaf81d287a9da
>Subject: [Intel-wired-lan] [next-queue v2] fm10k: add missing field
> initializers to TLV attributes)
>X-BeenThere: intel-wired-lan at osuosl.org
>X-Mailman-Version: 2.1.29
>Precedence: list
>List-Id: Intel Wired Ethernet Linux Kernel Driver Development
> <intel-wired-lan.osuosl.org>
>List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
> <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
>List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
>List-Post: <mailto:intel-wired-lan@osuosl.org>
>List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
>List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>, 
> <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
>MIME-Version: 1.0
>Content-Type: text/plain; charset="us-ascii"
>Errors-To: intel-wired-lan-bounces at osuosl.org
>Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>
>
>Add the missing field initializers for a couple of the TLV attribute
>macros. This resolves the last few -Wmissing-field-initializers warnings
>for the fm10k Linux driver.
>
>Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>---
> drivers/net/ethernet/intel/fm10k/fm10k_tlv.h | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
