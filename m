From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 18 Oct 2021 18:42:03 -0700
Subject: [Intel-wired-lan] [PATCH] ice: Fix clang -Wimplicit-fallthrough in
 ice_pull_qvec_from_rc()
Message-ID: <20211019014203.1926130-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Clang warns:

drivers/net/ethernet/intel/ice/ice_lib.c:1906:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
        default:
        ^
drivers/net/ethernet/intel/ice/ice_lib.c:1906:2: note: insert 'break;' to avoid fall-through
        default:
        ^
        break;
1 error generated.

Clang is a little more pedantic than GCC, which does not warn when
falling through to a case that is just break or return. Clang's version
is more in line with the kernel's own stance in deprecated.rst, which
states that all switch/case blocks must end in either break,
fallthrough, continue, goto, or return. Add the missing break to silence
the warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/1482
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index f981e77f72ad..03443c060507 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1903,6 +1903,7 @@ static struct ice_q_vector *ice_pull_qvec_from_rc(struct ice_ring_container *rc)
 	case ICE_TX_CONTAINER:
 		if (rc->tx_ring)
 			return rc->tx_ring->q_vector;
+		break;
 	default:
 		break;
 	}

base-commit: 939a6567f976efb8b3e6d601ce35eb56b17babd0
-- 
2.33.1.637.gf443b226ca

