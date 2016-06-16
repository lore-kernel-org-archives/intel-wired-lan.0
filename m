From: Hannes Frederic Sowa <hannes@stressinduktion.org>
Date: Fri, 17 Jun 2016 00:45:50 +0200
Subject: [Intel-wired-lan] [net-next PATCH v3 02/17] net: Combine GENEVE
 and VXLAN port notifiers into single functions
In-Reply-To: <20160616192052.20872.92437.stgit@localhost.localdomain>
References: <20160616191851.20872.67154.stgit@localhost.localdomain>
 <20160616192052.20872.92437.stgit@localhost.localdomain>
Message-ID: <d3bb41cb-3d1f-bcf2-7951-46e655d2ea94@stressinduktion.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16.06.2016 21:20, Alexander Duyck wrote:
> This patch merges the GENEVE and VXLAN code so that both functions pass
> through a shared code path.  This way we can start the effort of using a
> single function on the network device drivers to handle both of these
> tunnel types.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>

Acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>


