From: Simon Horman <simon.horman@corigine.com>
Date: Thu, 14 Oct 2021 11:05:13 +0200
Subject: [Intel-wired-lan] [PATCH net-next] ice: fix an error code in
 ice_ena_vfs()
In-Reply-To: <20211013080012.GB6010@kili>
References: <20211013080012.GB6010@kili>
Message-ID: <20211014090510.GA20127@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Oct 13, 2021 at 11:00:12AM +0300, Dan Carpenter wrote:
> Return the error code if ice_eswitch_configure() fails.  Don't return
> success.
> 
> Fixes: 1c54c839935b ("ice: enable/disable switchdev when managing VFs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>
