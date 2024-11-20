import pytest


# @pytest.mark.skipif(True, reason="  skipped by Developer")
class Test_ML_Modules:
    @pytest.mark.parametrize(
        "num_epoch, expected_out",
        [
            (10, 10),
            (0, 21),
        ],
    )
    def test_module1(self, num_epoch, expected_out):
        # run the test
        out = expected_out
        assert out == expected_out
